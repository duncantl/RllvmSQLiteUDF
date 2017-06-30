#CLANG=~/LLVM3.9/clang+llvm-3.9.0-x86_64-apple-darwin/bin/clang
#CLANG=~/LLVM3.7/clang+llvm-3.7.0-x86_64-apple-darwin/bin/clang
CLANG=clang
#R_HOME=$(shell R RHOME)
R_INC=${R_HOME}/include
#R_INC=/usr/share/R/include

fib.ll: fib.c GNUmakefile
	$(CLANG) -O3 -S -emit-llvm fib.c -I${R_INC} -I${HOME}/local/include

fib.so: fib.c
	R CMD SHLIB fib.c

%.ll: %.c GNUmakefile
	$(CLANG) -O3 -S -emit-llvm $< -I${HOME}/local/include

