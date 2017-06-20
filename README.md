This is an illustration of compiling an R function so that it can be used directly within
SQLite3 as a user-defined function.

##Note
On OSX, we are having issues getting this to work when compiled outside of the RSQLiteUDF package.
The same code works within that, but not in a separate shared library.
The fib.c C code and runC.R R code are here to simplify testing why the UDFs do not work outside
of the RSQLiteUDF package.

This works on Linux.

##Why?
Why do we want to do this? Firstly, the available extension functions in SQLite 
are not comprehensive and it is convenient to add new ones.
More importantly, we can avoid moving large amounts of data from the database to R.
Consider 
```
sum(dexp(x, 4))
```
where x is a column in a database.
We would compute this likehood value with
``` 
sum(dexp(dbGetQuery(db, "SELECT x from table"), 4))
```
However, if dexp() was defined as a UDF in the database, we could write
```
dbGetQuery(db, "SELECT sum(dexp(x, 4)) from table")
```
In this case, the database can fuse the loop for computing each `dexp(x[i])` and the sum.
We do not compute the entire vector of x values in the database, allocate a parallel vector
in R, copy the values and then compute a second vector `dexp(x)` and then loop over that 
to compute the sum().


##Implementation
The idea is reasonably straightforward. We'll use the fibonacci sequence as a silly example.
We need to compile code to calculate the Fibonacci value for a given input n.

We also need to create a wrapper routine that SQLite3 can invoke. 
The signature needs to be
```c
void sqlFib(sqlite3_context *context, int argc, sqlite3_value **argv)
```
The wrapper routine sqlFib is implemented as
```
void
sqlFib(sqlite3_context *context, int argc, sqlite3_value **argv)
{
   int arg = sqlite3_value_int(argv[0]);
   int ans = fib2(arg);
   sqlite3_result_int(context, ans);
}
```
We have assumed we are called with one argument and that it is an integer.
We could check the number and type(s) of the argument(s).

We need to generate the code for both sqlFib() and fib2().
We create a compiled version of this directly from a previously generated ll file.

##Using the Code in R
See run.R for the actual R code.

First we compile the code into machine code:
```r
library(Rllvm)
m = parseIR("fib.ll")
llvmAddSymbol("sqlite3_value_int", "sqlite3_result_int")
ee = ExecutionEngine(m)
```

Now we connect to the database:
```r
library(RSQLite)
library(RSQLiteUDF)
db = dbConnect(SQLite(), "foo")
sqliteExtension(db) 
```

```r
ptr = getPointerToFunction(m$sqlFib3, ee)
createSQLFunction(db, ptr@ref, "fib", nargs = 1L)
```

We can now test the UDF with 
```r
d = dbGetQuery(db, "SELECT fib(x) FROM mytable")
```

##Data
The data are created via the shell command
```
sqlite3 foo < data.sql
```

