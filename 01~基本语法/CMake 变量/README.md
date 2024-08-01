# CMake 变量

### 信息变量

#### CMAKE_SYSTEM

- 系统名称，例如 Linux-2.6.22、FreeBSD-5.4-RELEASE、Windows 5.1

#### CAMKE_SYSTEM_NAME

- 系统名称，如 Linux、FreeBSD、Windows

#### CMAKE_SYSTEM_VERSION

- 系统版本，如 2.6.22

#### CMAKE_SYSTEM_PROCESSOR

- 处理器名称，如 i686

#### UNIX

- bool，在所有的类 UNIX 平台为 TRUE，包括 OS X 和 cygwin

#### WIN32

- bool，在所有的 win32 平台为 TRUE，包括 cygwin

#### CMAKE_MAJOR_VERSION

- cmake 主版本号，如 2.8.6 中的 2

#### CMAKE_MINOR_VERSION

- cmake 次版本号，如 2.8.6 中的 8

#### CMAKE_PATCH_VERSION

- cmake 补丁等级，如 2.8.6 中的 6

### 预定义变量

- 在 CMakeLists.txt 中使用 set 指定
- cmake 命令中使用，如 cmake -DBUILD_SHARED_LIBS=OFF

#### PROJECT_NAME

- 返回通过 PROJECT 定义的项目名称

#### CMAKE_C_COMPILER

- C 编译器，默认 /usr/bin/cc

#### CMAKE_CXX_COMPILER

- C++编译器，默认 /usr/bin/c++。 也可通过指令 ADD_DEFINITIONS() 添加

#### CMAKE_C_FLAGS

- 编译 C 文件时的选项，默认为空，如 -g；也可以通过 add_definitions 添加编译选项

#### CMAKE_CXX_FLAGS

- 编译 C++ 文件时的选项，默认为空

#### CMAKE_INCLUDE_PATH

- 添加头文件搜索路径. 默认为空。配合 FIND_FILE() 以及 FIND_PATH 使用

#### CMAKE_LIBRARY_PATH

- 添加库文件搜索路径. 默认为空。配合 FIND_LIBRARY() 使用

#### CMAKE_INSTALL_PREFIX

- 定义 cmake 安装的路径, 默认 /usr/local

#### PROJECT_BINARY_DIR

- 运行 cmake 命令的目录，通常是 ${PROJECT_SOURCE_DIR}/build，同 CMAKE_BINARY_DIR、`<projectname>_BINARY_DIR`

#### PROJECT_SOURCE_DIR

- 工程的根目录，同 CMAKE_SOURCE_DIR、`<projectname>_SOURCE_DIR`

#### CMAKE_CURRENT_SOURCE_DIR

- 当前处理的 CMakeLists.txt 所在的路径

#### CMAKE_CURRENT_BINARY_DIR

- target 编译目录;
- 使用 ADD_SURDIRECTORY(src bin) 可以更改此变量的值;
- SET(EXECUTABLE_OUTPUT_PATH <新路径>) 并不会对此变量有影响,只是改变了最终目标文件的存储路径

#### CMAKE_PREFIX_PATH

- 默认为空。
- 指定要搜索的安装前缀的目录 find_package()， find_program()， find_library()， find_file()，和 find_path() 命令。
- 每个命令将添加相应的子目录（例如 bin，lib 或 include），作为其自己的文档中指定。默认空,由项目设定.

#### CMAKE_MODULE_PATH

- 默认为空。
- cmake 为上百个软件包提供了查找器 (finder):FindXXXX.cmake 当使用非 cmake 自带的 finder 时，需要指定 finder 的路径，这就是 CMAKE_MODULE_PATH，配合 FIND_PACKAGE() 使用
- SET(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)，然后可以用 INCLUDE 命令来调用自己的模块

#### CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS

- 用来控制 IF ELSE 语句的书写方式，默认为空。

#### CMAKE_BUILD_TYPE

- 控制构建类型。可选参数：
- - None: default
- - Debug: 生成调试信息
- - Release: 发布版本，进行最佳化
- 此值不会再 configure 的时候自动初始化，需手动设置
- 命令行参数 cmake -DCMAKE_BUILD_TYPE=Debug

#### BUILD_SHARED_LIBS

- 将所有程序库的 target 设置为共享库。如果未设置，使用 ADD_LIBRARY 时又没有指定库类型，默认编译生成静态库

#### EXECUTABLE_OUTPUT_PATH

- 定义目标二进制可执行文件的存放位置，默认为空

#### LIBRARY_OUTPUT_PATH

- 定义目标链接库文件的存放位置，默认为空
