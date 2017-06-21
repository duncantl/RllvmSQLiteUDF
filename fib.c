void showAPI();

int
fib2(int n)
{
    if(n < 2)
	return(n);
    
    return(fib2(n-1) + fib2(n-2));
}

#include <sqlite3ext.h>
//#define SQLITE_CORE 1
//extern sqlite3_api_routines *sqlite3_api;
//static SQLITE_EXTENSION_INIT1
static const sqlite3_api_routines *sqlite3_api;

#if 0
#include <stdio.h>
#endif

void
sqlFib3(sqlite3_context *context, int argc, sqlite3_value **argv)
{
#if 0
   int type = sqlite3_value_type(argv[0]);
   fprintf(stderr, "# args %d, data type in sqlFib2 %d\n", argc, type);fflush(stderr);
#endif
   int arg = sqlite3_value_int(argv[0]);
   int ans = fib2(arg);
   sqlite3_result_int(context, ans);
}

#include "Rdefines.h"

void
sqlTen(sqlite3_context *context, int argc, sqlite3_value **argv)
{
Rprintf("sqlite3_api %p %p\n", sqlite3_api, sqlite3_api->value_int);
     sqlite3_result_int(context, 10);
}





SEXP
R_setSQLite3API(SEXP ptr)
{
  sqlite3_api = ( (sqlite3_api_routines *) R_ExternalPtrAddr(ptr));
//Rprintf("sqlite3_api %p %d\n", sqlite3_api, (sqlite3_api->value_int != NULL));
//  Rprintf("sqlite3_api %p\n", sqlite3_api);
  return(R_NilValue);
}

SEXP
R_2setSQLite3API(SEXP ptr)
{
  return(R_NilValue);
}

SEXP
R_getSQLite3API()
{
//Rprintf("sqlite3_api %p %d\n", sqlite3_api, (sqlite3_api->value_int != NULL));
    return(R_MakeExternalPtr((void *) sqlite3_api, R_NilValue, R_NilValue));
}



int 
sqlite3_fib_init(sqlite3 *db,          /* The database connection */
                 char **pzErrMsg,      /* Write error messages here */
                 const sqlite3_api_routines *pApi  /* API methods */
                )
{
  Rprintf("in sqlite3_fib_init\n");
    SQLITE_EXTENSION_INIT2(pApi);
    showAPI()    ;
//    sqlite3_create_function(db, "registerFun", 2, SQLITE_UTF8, NULL, R_registerFunc, NULL, NULL);
//    sqlite3_create_function(db, "ifloor", 1, SQLITE_UTF8, NULL, myfloorFunc, NULL, NULL);
    return(SQLITE_OK);
}





void
showAPI()
{

  Rprintf(" sqlite3_api = %p\n", sqlite3_api);
  if(sqlite3_api) {
     if(sqlite3_api->value_int)
        Rprintf(" sqlite3_api->value_int = %p\n", sqlite3_api->value_int);
     else
        Rprintf("  sqlite3_api->value_int = NULL\n");
  }
}
