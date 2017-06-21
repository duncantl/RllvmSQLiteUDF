
#include <Rdefines.h>
SEXP
R_foo()
{
    return(ScalarInteger(10));
}


SEXP
R_bar(SEXP x)
{
    return(ScalarInteger(10 + INTEGER(x)[0]));
}


SEXP
R_nil()
{
    return(R_NilValue);
}

SEXP
R_nilPtr(SEXP ext)
{
    return(R_NilValue);
}
