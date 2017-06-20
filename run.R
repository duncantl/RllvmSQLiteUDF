    # git@github.com:duncantl/RSQLiteUDF.git

# RSQLiteUDF needs RSQlite version 1.0-0, not greater than this, for now!
if(require("RSQLite") && require("RSQLiteUDF") && require("Rllvm")) {

m = parseIR("fib_basic.ll")
ee = ExecutionEngine(m)

# Check code works
ans = .llvm(m$fib1, 10L, .ee = ee)
print(ans)
# Answer = 55

db = dbConnect(SQLite(), "foo")
sqliteExtension(db) 

ptr = getPointerToFunction(m$fib1, ee)
createSQLFunction(db, ptr@ref, "fib", nargs = 1L)
d = dbGetQuery(db, "SELECT fib(x) FROM mytable LIMIT 5")
}
