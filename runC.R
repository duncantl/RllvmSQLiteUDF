library("RSQLite")
library("RSQLiteUDF")
db = dbConnect(SQLite(), "foo")
sqliteExtension(db)


sqliteExtension(db, system.file("libs", "RSQLiteUDF.so", package = "RSQLiteUDF"))
a = getNativeSymbolInfo("sqlite3_api", "RSQLiteUDF")$address
#sqliteExtension(db, "fib.so")

dll = dyn.load("fib.so")
.Call(dll$R_setSQLite3API, a)

p = getNativeSymbolInfo("sqlTen")
createSQLFunction(db, p, "ten", nargs = 0L)

d = dbGetQuery(db, "SELECT ten()")


########

p = getNativeSymbolInfo("sqlFib3")
createSQLFunction(db, "sqlFib3", "fib3", nargs = 1L)


d = dbGetQuery(db, "SELECT x, fib3(x) FROM mytable")



#################
createSQLFunction(db, "myfloorFunc", "myfloor", nargs = 1L)
d = dbGetQuery(db, "SELECT myfloor(y) FROM mytable LIMIT 5")


p = getNativeSymbolInfo("sqlFib2")
createSQLFunction(db, p, "fib2", nargs = 1L)
d = dbGetQuery(db, "SELECT x, fib2(x) FROM mytable")
