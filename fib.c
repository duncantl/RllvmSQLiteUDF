int
fib2(int n)
{
    if(n < 2)
	return(n);
    
    return(fib2(n-1) + fib2(n-2));
}

#include <sqlite3ext.h>
SQLITE_EXTENSION_INIT1

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



