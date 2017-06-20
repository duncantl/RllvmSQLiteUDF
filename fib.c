int
fib2(int n)
{
    if(n < 2)
	return(n);
    
    return(fib2(n-1) + fib2(n-2));
}

#include <sqlite3ext.h>
SQLITE_EXTENSION_INIT1


void
sqlFib3(sqlite3_context *context, int argc, sqlite3_value **argv)
{
   int arg = sqlite3_value_int(argv[0]);
   int ans = fib2(arg);
   sqlite3_result_int(context, ans);
#if 0
   int type = sqlite3_value_type(argv[0]);
   fprintf(stderr, "# args %d, data type in sqlFib2 %d\n", argc, type);fflush(stderr);
#endif
}



int 
sqlite3_extension_init(sqlite3 *db,          /* The database connection */
                       char **pzErrMsg,      /* Write error messages here */
                       const sqlite3_api_routines *pApi  /* API methods */
                      )
{

    SQLITE_EXTENSION_INIT2(pApi);
//    sqlite3_create_function(db, "registerFun", 2, SQLITE_UTF8, NULL, R_registerFunc, NULL, NULL);
//    sqlite3_create_function(db, "ifloor", 1, SQLITE_UTF8, NULL, myfloorFunc, NULL, NULL);
    return(SQLITE_OK);
}
