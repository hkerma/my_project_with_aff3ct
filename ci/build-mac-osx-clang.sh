#!/bin/bash
set -x

examples=(bootstrap tasks factory)

function compile {
	mkdir build_test
	cd build_test
	cmake .. -G"Unix Makefiles" -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-Wall -funroll-loops -march=native -Wno-deprecated-declarations"
	THREADS=$(grep -c ^processor /proc/cpuinfo)
	make -j $THREADS
	cd ..
}

cd examples
for example in ${examples[*]}; do
	cd $example
	compile
	cd ..
done