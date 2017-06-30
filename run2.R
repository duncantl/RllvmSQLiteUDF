

library("RSQLite")
library("RSQLiteUDF")
library("Rllvm") 

db = dbConnect(SQLite(), "foo")

m = parseIR("minSQLFib.ll")
llvmAddSymbol(getNativeSymbolInfo("sqlite3_value_int"))
llvmAddSymbol(getNativeSymbolInfo("sqlite3_result_int"))

ee = ExecutionEngine(m)

ans = .llvm(m$fib2, 10L, .ee = ee)
stopifnot(ans == 55)


b = .Call("R_getSQLite3API", PACKAGE = "RSQLiteUDF")
sqliteExtension(db, system.file("libs", "RSQLiteUDF.so", package = "RSQLiteUDF"))
b = .Call("R_getSQLite3API", PACKAGE = "RSQLiteUDF")


cif = Rffi::CIF(Rffi::voidType, list(Rffi::pointerType))
.llvm(m$R_setSQLite3API, b, .ee = ee, .ffi = cif)


ptr = getPointerToFunction(m$sqlFib3, ee)
createSQLFunction(db, ptr@ref, "fib", nargs = 1L)
d = dbGetQuery(db, "SELECT fib(x) FROM mytable")

