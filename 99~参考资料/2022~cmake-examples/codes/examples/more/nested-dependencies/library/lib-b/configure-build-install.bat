@echo off

cmake -B build -DCMAKE_INSTALL_PREFIX=./install
cmake --build build --target install
