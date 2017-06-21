

fib.ll: fib.c GNUmakefile
	~/LLVM3.9/clang+llvm-3.9.0-x86_64-apple-darwin/bin/clang -O3 -S -emit-llvm fib.c -I${R_HOME}/include -I${HOME}/local

fib.so: fib.c
	R CMD SHLIB fib.c
