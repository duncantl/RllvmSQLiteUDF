require("RSQLite") && require("RSQLiteUDF")
db = dbConnect(SQLite(), "foo")
sqliteExtension(db)

createSQLFunction(db, "myfloorFunc", "myfloor", nargs = 1L)
d = dbGetQuery(db, "SELECT myfloor(x) FROM mytable LIMIT 5")

dyn.load("fib.so")
p = getNativeSymbolInfo("sqlFib2")
createSQLFunction(db, p, "fib2", nargs = 1L)
d = dbGetQuery(db, "SELECT fib2(x) FROM mytable LIMIT 5")
