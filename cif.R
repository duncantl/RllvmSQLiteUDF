dyn.load("fib.so")
library(Rffi)
r = getNativeSymbolInfo("R_setSQLite3API")$address
b = new("externalptr")
callCIF(Rffi::CIF(Rffi::sexpType, list(Rffi::sexpType)), r, b, returnInputs = FALSE)


r = getNativeSymbolInfo("R_getSQLite3API")
callCIF(Rffi::CIF(Rffi::sexpType), r, returnInputs = FALSE)
