#!/bin/bash

cmake -B build/debug -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_PREFIX_PATH=$(pwd)/../library/install
cmake -B build/release -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH=$(pwd)/../library/install
