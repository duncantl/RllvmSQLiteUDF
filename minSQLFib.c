int
fib2(int n)
{
    if(n < 2)
	return(n);
    
    return(fib2(n-1) + fib2(n-2));
}

#include <sqlite3ext.h>
static const sqlite3_api_routines *sqlite3_api;


void
sqlFib3(sqlite3_context *context, int argc, sqlite3_value **argv)
{
   int arg = sqlite3_value_int(argv[0]);
   int ans = fib2(arg);
   sqlite3_result_int(context, ans);
}


void
R_setSQLite3API(void *ptr)
{
   sqlite3_api = (sqlite3_api_routines*) ptr;
}


