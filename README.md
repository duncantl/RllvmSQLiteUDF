#  NOTE - Version of RSQLite

**NOTE**  For now, we use RSQLite version 1.0.0.
In the future, we will make this work with subsequent versions of RSQLite.
The reason is that accessing the C-level pointer to the database was changed
in versions >  1.0.0 due to the use of Rcpp and I haven't had the time to chase this down.
This is a minor technical matter. The focus here is on the proof of concept
and the logistics to make it work.

# Compiling an R Function as a User-Defined Function in SQLite3

This is an illustration of compiling an R function so that it can be used directly within
SQLite3 as a user-defined function.

A similar and simpler example is a user-defined function for XPath and illustrated in
[RllvmXPathUDF](https://github.com/duncantl/RllvmXPathUDF).

##How to run the example
```
make minSQLFib.ll
Rscript run2.R
```
You may not need to create minSQLFib.ll, but if you get an error in the call to parseIR(),
you will.  This happens when you use a version of LLVM that is different from
the version of clang used to create the fib.ll file and the format of the IR is slightly different.


##Why?
Why do we want to do this? Firstly, the available extension functions in SQLite 
are not comprehensive and it is convenient to add new ones.
More importantly, we can avoid moving large amounts of data from the database to R.
Consider 
```
sum(log(dexp(x, 4)))
```
where x is a column in a database.
We would compute this likehood value with
``` 
sum(log(dexp(dbGetQuery(db, "SELECT x from table"), 4)))
```
However, if dexp() was defined as a UDF in the database, we could write
```
dbGetQuery(db, "SELECT sum(log(dexp(x, 4))) from table")
```
In this case, the database can fuse the loop for computing each `dexp(x[i])`, the `log()` and the sum().
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
```c
void
sqlFib(sqlite3_context *context, int argc, sqlite3_value **argv)
{
   int arg = sqlite3_value_int(argv[0]);
   int ans = fib2(arg);
   sqlite3_result_int(context, ans);
}
```
We have assumed our UDF will be called with one argument and that it is compatible with an integer.
We could check the number and type(s) of the argument(s).

We need to generate the code for both sqlFib() and fib2().
We would do this directly from Rllvm (or RLLVMCompile). However, for this example,
we create a compiled version of this directly from a previously generated ll file.

##Using the Code in R
See run1.R for the actual R code.

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
sqliteExtension(db, pkg = "RSQLiteUDF") 
```

```r
ptr = getPointerToFunction(m$sqlFib3, ee)
createSQLFunction(db, ptr@ref, "fib", nargs = 1L)
```

We can now test the UDF with 
```r
d = dbGetQuery(db, "SELECT fib(x) FROM mytable")
```

There is an extra step that is needed for SQLite3. This is discussed in the <a href="#Note2">Note below</a>.




## dexp() example

```
ptr = getPointerToFunction(m$sqlDexp, ee)
createSQLFunction(db, ptr@ref, "dexp", nargs = 2L)
d1 = dbGetQuery(db, "SELECT dexp(y/x, 1.2) FROM mytable")
```r

To compute the log-likelihood, we need to register an extension function for log:
```r
createSQLFunction(db, getNativeSymbolInfo("sqlLog", "RSQLiteUDF"), "log", nargs = 1L)
```

And now we can use sum(), log() and dexp() in our SQL query:
```r
d2 = dbGetQuery(db, "SELECT sum(log(dexp(y/x, 1.2))) FROM mytable")
```



##Data
The data are created via the shell command
```
sqlite3 foo < data.sql
```



##Note1
The fib.c C code and runC.R R code are here to simplify testing why the UDFs do not work outside
of the RSQLiteUDF package.

<h2><a name="Note2">Note2</a></h2>
Each SQLite3 extension contains a global variable named sqlite3_api within that extension.
This is a struct of type sqlite3_api_routines and has all the routines we need to implement the
SQLite3 API and are used in higher-level calls such as sqlite3_value_int and
sqlite3_result_int that we use in our wrapper routine above.

This sqlite3_api variable is initialized to `NULL`.  However, the idiom is that we set it in our
extension initialization routine that SQLite3 invokes when we register the extension by specifying
the DLL containing the extension code.  SQLite3 loads that DLL and then calls its SQLite3-specific
initialization routine (e.g. sqlite3_extension_init), passing an object we can use to set
sqlite3_api.  Once that is set, we can register and use the UDF routines in SQL commands.

Our situation is more complicated. We don't have a DLL that we ask SQLite3 to load.
Our routines are in memory since we generated the code directly via LLVM.
As a result, there is no direct mechanism by which we can access the object that SQLite3
would pass to our initialization routine so that we can set sqlite3_api approriately.

We use the following approach.  We load the RSQLiteUDF DLL. SQLite3 then calls
its sqlite3_extension_init() routine and we initialize the sqlite3_api variable
in that DLL.  This is different from the one in our LLVM generated Module.
However, we get the value of the RSQLiteUDF::sqlite3_api variable and we set
sqlite3_api  in our LLVM module to that same value. 

To do this, we have a routine in RSQLiteUDF to obtain the value of its sqlite3_api value.
We also added a routine in our LLVM module to take an R external pointer object and use
its value to set the sqlite3_api variable in the LLVM module.
These two steps are done in the following important lines in run1.R:
```r
b = .Call("R_getSQLite3API", PACKAGE = "RSQLiteUDF")
.llvm(m$R_setSQLite3API, b, .ee = ee, .ffi = Rffi::CIF(Rffi::sexpType, list(Rffi::sexpType)))
```
This is done before we invoke any UDFs, and it is probably most prudent to do it before
registering any UDFs.




