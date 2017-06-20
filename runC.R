require("RSQLite") && require("RSQLiteUDF")
db = dbConnect(SQLite(), "foo")
sqliteExtension(db)


dyn.load("fib.so")
p = getNativeSymbolInfo("sqlFib3")
createSQLFunction(db, "sqlFib3", "fib3", nargs = 1L)
d = dbGetQuery(db, "SELECT x, fib3(x) FROM mytable")




createSQLFunction(db, "myfloorFunc", "myfloor", nargs = 1L)
d = dbGetQuery(db, "SELECT myfloor(y) FROM mytable LIMIT 5")


p = getNativeSymbolInfo("sqlFib2")
createSQLFunction(db, p, "fib2", nargs = 1L)
d = dbGetQuery(db, "SELECT x, fib2(x) FROM mytable")
