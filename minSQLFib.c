int
fib2(int n)
{
    if(n < 2)
	return(n);
    
    return(fib2(n-1) + fib2(n-2));
}

#include <math.h>

double
dexp(double x, double lambda)
{
    return( lambda * exp(- (lambda * x)) );
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
sqlDexp(sqlite3_context *context, int argc, sqlite3_value **argv)
{
   double x = sqlite3_value_double(argv[0]);
   double lambda = sqlite3_value_double(argv[1]);
   double ans = dexp(x, lambda);
   sqlite3_result_double(context, ans);
}


void
R_setSQLite3API(void *ptr)
{
   sqlite3_api = (sqlite3_api_routines*) ptr;
}


