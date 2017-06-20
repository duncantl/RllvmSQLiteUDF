    # git@github.com:duncantl/RSQLiteUDF.git

# RSQLiteUDF needs RSQlite version 1.0-0, not greater than this, for now!
library("RSQLite")
library("RSQLiteUDF")
library("Rllvm") 

db = dbConnect(SQLite(), "foo")
sqliteExtension(db) 


m = parseIR("fib.ll")
llvmAddSymbol(getNativeSymbolInfo("sqlite3_value_int"))
llvmAddSymbol(getNativeSymbolInfo("sqlite3_result_int"))

ee = ExecutionEngine(m)

a = getNativeSymbolInfo("sqlite3_api")$address
.llvm(m$R_setSQLite3API, a, .ee = ee)
.llvm(m$R_getSQLite3API, .ee = ee)
#m[["sqlite3_api"]] = a


# Check code works
ans = .llvm(m$fib2, 10L, .ee = ee)
print(ans)
# Answer = 55


ptr = getPointerToFunction(m$sqlTen, ee)
createSQLFunction(db, ptr@ref, "ten", nargs = 0L)
d = dbGetQuery(db, "SELECT ten()")

ptr = getPointerToFunction(m$sqlFib3, ee)
createSQLFunction(db, ptr@ref, "fib", nargs = 1L)
d = dbGetQuery(db, "SELECT fib(x) FROM mytable LIMIT 5")

dyn.load("fib.so")
p = getNativeSymbolInfo("fib2")
createSQLFunction(db, p, "fib2", nargs = 1L)
d = dbGetQuery(db, "SELECT fib2(x) FROM mytable LIMIT 5")
}
