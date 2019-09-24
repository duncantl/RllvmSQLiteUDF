# This is highly analogous to RllvmXPathUDF's getXPathWrapper.
# We create the IR for the wrapper Function based on our knowledge
# of the SQL UDF mechanism.
# This is slightly different as outlined in the llvm.xml document because
# of macros and function pointers rather than regular routines.
# Also we need to create a local instance of the sqlite3_api pointer object and
# arrange to initialize it.

# See sqlite3_api_routines_fieldNames  at the bottom

if(FALSE) {
library(Rllvm)
source("genSQLiteUDFWrapper.R")    
m = parseIR("fib_basic.ll") # may want to clone
wf = genSQLiteUDFWrapper(m$fib1, module = m)


library("RSQLite")
library("RSQLiteUDF")
db = dbConnect(SQLite(), "foo")
sqliteExtension(db, system.file("libs", "RSQLiteUDF.so", package = "RSQLiteUDF"))
b = .Call("R_getSQLite3API", PACKAGE = "RSQLiteUDF")

ee = ExecutionEngine(m)

llvmAddSymbol("R_ExternalPtrAddr")  # providUndefFunctions(m)
.llvm(m$R_setSQLite3API, b, .ee = ee)

ptr = getPointerToFunction(m$sqlfib1, ee)
createSQLFunction(db, ptr@ref, "fib", nargs = 1L)
d = dbGetQuery(db, "SELECT fib(x) FROM mytable")

# raise error
d = dbGetQuery(db, "SELECT fib(x, 2) FROM mytable")
}

getSQLTypes =
function(tmod = parseIR("simpleSQL.ll"))    
{
     # sqlite3_api_routines - not pointer
    ty = getElementType(getElementType(getType(tmod[["sqlite3_api"]])))
    api_routines = as(ty, "StructType")

    fields = getFields(api_routines)
    
      # sqlite3_context *
    ctxt = getParameters(as(getElementType(fields[[1]]), "FunctionType"))[[1]]

      # sqlite3_value *
    valTy = getParameters(as(getElementType(fields[[107]]), "FunctionType"))[[1]]
    
    list(api_routines = api_routines, context = ctxt, value = valTy)
}

genSQLiteUDFWrapper =
function(fun, params = getParameters(fun), retType = getReturnType(fun), module = as(fun, "Module"),
         funName = sprintf("sql%s", getName(fun)),
         sqlTypes = getSQLTypes(),
         api = "sqlite3_api", addAPISet = TRUE)
{

     if(is.character(api) && ! (api %in% names(module))) 
        api = createGlobalVariable(api, module, pointerType(sqlTypes$api_routines), NULL, linkage = InternalLinkage)

           # declare new wrapper routine with 2 parameters xmlXPathContent pointer and int of number of arguments.
     f = Function(funName, VoidType, list(ctxt = sqlTypes$context, argc = Int32Type, argv = pointerType(sqlTypes$value)), module = module)


     nparams = getParameters(f)
     ctxt = nparams[[1]]
     nargs = nparams[[2]]
     args = nparams[[3]]     
     b = Block(f)
     ir = IRBuilder(b)

      # We have the initial block that determines if the number of arguments is correct. If not, jump to
      # errBlock which calls xmlXPathErr
      # Otherwise, jump to the bodyBlock which performs the computations.
      # And both errBlock and bodyBlock jump to returnBlock to exit the routine.
     bodyBlock = Block(f)
     errBlock = Block(f)
     returnBlock = Block(f)     

     cmp = createICmp(ir, ICMP_EQ, nparams[[2]], ir$createIntegerConstant(length(params), getContext(module)))     
     createCondBr(ir, cmp, bodyBlock, errBlock)

       # create the bodyBlock code
     ir$setInsertPoint(bodyBlock)
     args = mapply(function(p, i)
                       popArg(ir, getType(p), args, i, module, api),
                   params, seq(along = params), SIMPLIFY = FALSE)

      # call the function being wrapped, i.e. the original function of interest.
     val = createCall(ir, fun, .args = args)

     pushResult(ir, val, retType, ctxt, module, api)
     ir$createBr(returnBlock)

       # Create the errBlock code.
     ir$setInsertPoint(errBlock)
     createUDFError(ir, nparams, length(params), module, returnBlock, c(getName(f), getName(fun)), api)

       # Create the simple returnBlock code which is just return with a void.
     ir$setInsertPoint(returnBlock)
     createReturn(ir)

     if(addAPISet && !("R_setSQLite3API" %in% names(module)))
        genSetAPI(module, api)
     
     f     
}


createUDFError =
function(ir, udfparams, numExpected, module, returnBlock, funNames, api)
{
#    fmt = sprintf("Expected %d arguments for %s, got XXX", numExpected, origFunName)
#    fmt = sprintf("Expected %d arguments for %s, got %%d", numExpected, origFunName)
    rmsg = sprintf("incorrect number of arguments to %s (proxy for %s), expecting %d arguments", funNames[1], funNames[2], numExpected)
    # have the compiled code insert udfparams[[2]] at the end of the string at position i.
    # and put a \0 after this
    #     i = gregexpr("XXX", fmt)[[1]]
    # or do the sprintf directly in msg
    # sprintf(msg, fmt, udfparams[[2]])
    # The third argument to result_error indicates that the string is 0-terminated.
    # Otherwise, we provide the number of bytes in the string.
    #  result_error(udfparams, msg, -1);

    i = match("result_error", sqlite3_api_routines_fieldNames)

    api = ir$createLoad(api)
    fun = ir$createGEP(api, c(0L, i - 1L))
    errf = ir$createLoad(fun)        


     # fixed error message as global array, then GEP to first character
    msg = createGlobalVariable("ErrMsg", module, , rmsg, InternalLinkage)
    msg = ir$createGEP(msg, c(0L, 0L))    
    mone = ir$createIntegerConstant(-1L, getContext(module))
    createCall(ir, errf, udfparams[[1]], msg, mone)
    
    ir$createBr(returnBlock)
}


popArg =
    #
    # Code to pop an argument from the XPath call as a native compiled type.
    # Determine the type expected for this parameter in the wrapped routine and
    # pop an instance of that most appropriate type from the XPath stack.
    # Cast the resulting value to the more specific native type expected by the routine.
    #
    # ty = the type the wrapped routine expects for this argument.
    # argNum so we can do equivalent of args[[argNum]]
    # api - the sqlite3_api instance so we can get the relevant function pointer from its fields.
function(ir, ty, args, argNum, module, api)
{
   # Determine which field in the ctxt we need to access to get the UDF value.
    #XXX generalize
    if(isIntegerType(ty) || identical(ty, Int1Type))
       pop = "value_int"
    else if( identical(ty, DoubleType)) 
       pop = "valid_double"
    else if(identical(StringType, ty))
       pop = "value_text"
    else
       stop("don't know how to marshall SQL type to LLVM type ", getName(ty))

    i = match(pop, sqlite3_api_routines_fieldNames)
    if(is.na(i))
        stop("No matching field in sqlite3_api_routines_fieldNames")

    #  api[i]( args[argNum ] )
    # load api[i]
    api = ir$createLoad(api)
    fun = ir$createGEP(api, c(0L, i - 1L))
    pop = ir$createLoad(fun)

     # load args[argNum]
    arg = ir$createGEP(args, argNum - 1L)

     # call api[i]( args[argNum ] )
    k = createCall(ir, pop, ir$createLoad(arg))

   if(FALSE && !identical(getType(k) , ty)) { #XXX come back to 
       #XX generalize
     createCast(ir, Rllvm:::FPToSI, k, ty)
   } else
     k
}



pushResult =
    #
    # Arrange the call to valuePush(), converting the return value from our wrappee function
    # to an XPath object.  Currently can handle Boolean, Float and CString, or variants that can be
    # cast to one of these, e.g., int to Float.
    #
function(ir, val, retType, ctxt, module, api)
{
      # Determine which xmlXPathNew routine to call to convert the return value from our wrapped routine
      # to an appropriate XPath object.
    if(isIntegerType(retType) || identical(retType, Int1Type))
       xnew = "result_int"        
    else if(identical(retType, DoubleType))
       xnew = "result_double"
    else if(identical(StringType, retType) || (isPointerType(retType) && identical(Int8Type, getElementType(retType))))
        xnew = "result_text"
    else
        stop("no matching type")

if(FALSE) {  #XXX come back to
    ty = getType(getParameters(xnew)[[1]])
    if(!identical(ty, retType)) {
        #XXX  make more general
        val = createCast(ir, Rllvm:::SIToFP, val, ty)
    }
}

    i = match(xnew, sqlite3_api_routines_fieldNames)
    if(is.na(i))
        stop("No matching field in sqlite3_api_routines_fieldNames")    

    api = ir$createLoad(api)
    fun = ir$createGEP(api, c(0L, i - 1L))
    xnew = ir$createLoad(fun)    
    
     # Create the new SQL object
    xval = createCall(ir, xnew, ctxt, val)
}


genSetAPI2 =
    #
    # There are now 2 versions of this - one that passes the pointer and the other than passes the 
    #  R external pointer object.
    # The latter is easier call as it does not need a CIF. So we generate that by default. But one can have both.
function(m, api, name = "setSQLite3API")    
{
  f2 = Function(name, VoidType, list(pointerType(VoidType)), m)
  b = Block(f2)
  ir = IRBuilder(b)
  val = getParameters(f2)[[1]]
  ir$createStore( val, ir$createBitCast( api, pointerType(getType(val))))

  ir$createReturn()

  f2
}

genSetAPI =
function(m, api, name = "R_setSQLite3API")    
{
  f2 = Function(name, SEXPType, list(SEXPType), m)
  b = Block(f2)
  ir = IRBuilder(b)
  val = getParameters(f2)[[1]]
  R_ExternalPtrAddr = Function("R_ExternalPtrAddr", pointerType(VoidType), list(SEXPType), m)
  ptr = ir$createCall(R_ExternalPtrAddr, val)
  
  ir$createStore( ptr, ir$createBitCast( api, pointerType(getType(ptr))))
  ir$createReturn(val)

  f2
}


sqlite3_api_routines_fieldNames = 
c("aggregate_context", "aggregate_count", "bind_blob", "bind_double", 
"bind_int", "bind_int64", "bind_null", "bind_parameter_count", 
"bind_parameter_index", "bind_parameter_name", "bind_text", "bind_text16", 
"bind_value", "busy_handler", "busy_timeout", "changes", "close", 
"collation_needed", "collation_needed16", "column_blob", "column_bytes", 
"column_bytes16", "column_count", "column_database_name", "column_database_name16", 
"column_decltype", "column_decltype16", "column_double", "column_int", 
"column_int64", "column_name", "column_name16", "column_origin_name", 
"column_origin_name16", "column_table_name", "column_table_name16", 
"column_text", "column_text16", "column_type", "column_value", 
"commit_hook", "complete", "complete16", "create_collation", 
"create_collation16", "create_function", "create_function16", 
"create_module", "data_count", "db_handle", "declare_vtab", "enable_shared_cache", 
"errcode", "errmsg", "errmsg16", "exec", "expired", "finalize", 
"free", "free_table", "get_autocommit", "get_auxdata", "get_table", 
"global_recover", "interruptx", "last_insert_rowid", "libversion", 
"libversion_number", "malloc", "mprintf", "open", "open16", "prepare", 
"prepare16", "profile", "progress_handler", "realloc", "reset", 
"result_blob", "result_double", "result_error", "result_error16", 
"result_int", "result_int64", "result_null", "result_text", "result_text16", 
"result_text16be", "result_text16le", "result_value", "rollback_hook", 
"set_authorizer", "set_auxdata", "xsnprintf", "step", "table_column_metadata", 
"thread_cleanup", "total_changes", "trace", "transfer_bindings", 
"update_hook", "user_data", "value_blob", "value_bytes", "value_bytes16", 
"value_double", "value_int", "value_int64", "value_numeric_type", 
"value_text", "value_text16", "value_text16be", "value_text16le", 
"value_type", "vmprintf", "overload_function", "prepare_v2", 
"prepare16_v2", "clear_bindings", "create_module_v2", "bind_zeroblob", 
"blob_bytes", "blob_close", "blob_open", "blob_read", "blob_write", 
"create_collation_v2", "file_control", "memory_highwater", "memory_used", 
"mutex_alloc", "mutex_enter", "mutex_free", "mutex_leave", "mutex_try", 
"open_v2", "release_memory", "result_error_nomem", "result_error_toobig", 
"sleep", "soft_heap_limit", "vfs_find", "vfs_register", "vfs_unregister", 
"xthreadsafe", "result_zeroblob", "result_error_code", "test_control", 
"randomness", "context_db_handle", "extended_result_codes", "limit", 
"next_stmt", "sql", "status", "backup_finish", "backup_init", 
"backup_pagecount", "backup_remaining", "backup_step", "compileoption_get", 
"compileoption_used", "create_function_v2", "db_config", "db_mutex", 
"db_status", "extended_errcode", "log", "soft_heap_limit64", 
"sourceid", "stmt_status", "strnicmp", "unlock_notify", "wal_autocheckpoint", 
"wal_checkpoint", "wal_hook", "blob_reopen", "vtab_config", "vtab_on_conflict", 
"close_v2", "db_filename", "db_readonly", "db_release_memory", 
"errstr", "stmt_busy", "stmt_readonly", "stricmp", "uri_boolean", 
"uri_int64", "uri_parameter", "xvsnprintf", "wal_checkpoint_v2", 
"auto_extension", "bind_blob64", "bind_text64", "cancel_auto_extension", 
"load_extension", "malloc64", "msize", "realloc64", "reset_auto_extension", 
"result_blob64", "result_text64", "strglob", "value_dup", "value_free", 
"result_zeroblob64", "bind_zeroblob64", "value_subtype", "result_subtype", 
"status64", "strlike", "db_cacheflush", "system_errno", "trace_v2", 
"expanded_sql", "set_last_insert_rowid", "prepare_v3", "prepare16_v3", 
"bind_pointer", "result_pointer", "value_pointer", "vtab_nochange", 
"value_nochange", "vtab_collation", "keyword_count", "keyword_name", 
"keyword_check", "str_new", "str_finish", "str_appendf", "str_vappendf", 
"str_append", "str_appendall", "str_appendchar", "str_reset", 
"str_errcode", "str_length", "str_value", "create_window_function", 
"normalized_sql", "stmt_isexplain", "value_frombind")
