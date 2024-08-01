## file

查找某些文件并构成一个文件列表变量

```sh
file(GLOB LIB_CPP_SRCS ${CMAKE_SOURCE_DIR}/src/*.cpp)
file(GLOB_RECURSE LIB_CPP_SRCS ${CMAKE_SOURCE_DIR}/src/*.cpp)
```

## list

```h
list(LENGTH <list><output variable>)
list(GET <list> <elementindex> [<element index> ...]<output variable>)
list(APPEND <list><element> [<element> ...])
list(FIND <list> <value><output variable>)
list(INSERT <list><element_index> <element> [<element> ...])
list(REMOVE_ITEM <list> <value>[<value> ...])
list(REMOVE_AT <list><index> [<index> ...])
list(REMOVE_DUPLICATES <list>)
list(REVERSE <list>)
list(SORT <list>)
```

- LENGTH：返回 list 的长度
- GET：返回 list 中 index 的 element 到 value 中
- APPEND：添加新 element 到 list 中
- FIND：返回 list 中 element 的 index，没有找到返回 -1
- INSERT：将新 element 插入到 list 中 index 的位置
- REMOVE_ITEM：从 list 中删除某个 element
- REMOVE_AT：从 list 中删除指定 index 的 element
- REMOVE_DUPLICATES：从 list 中删除重复的 element
- REVERSE：将 list 的内容反转
- SORT：将 list 按字母顺序排序

## include_directories

将指定目录添加到编译器的头文件搜索路径之下，指定的目录被解释成当前源码路径的相对路径

```sh
include_directories(${CMAKE_SOURCE_DIR}/src)
```

该命令不会进行递归查找，正常情况下只需要 include src 目录即可，引用头文件时相对于 src 路径填写头文件路径

## include

用于包含其他 cmake 文件：

```sh
include_directories(${CMAKE_SOURCE_DIR}/third_path.cmake)
```

## add_subdirectory

添加子目录，子目录中需要也有 cmake 文件，使用该命令即运行子目录的 cmake 文件。子目录中的 set 命令默认有效范围仅子目录和子目录的子目录，如果想令子目录的 set 在上层目录生效，需要加上 PARENT_SCOPE 参数，但是这样在子目录就无法生效了：

```sh
add_subdirectory(src/proto)
```

## add_library

将指定的源文件生成库文件：

```sh
# SHARED，动态库
# STATIC，静态库
# MODULE，在使用 dyld 的系统有效，如果不支持 dyld，则被当作 SHARED 对待。

SET(LIBHELLO_SRC hello.c)
add_library(hello_shared SHARED ${LIBHELLO_SRC})
set_target_properties(hello_shared PROPERTIES OUTPUT_NAME "hello")
add_library(hello_static STATIC ${LIBHELLO_SRC})
set_target_properties(hello_static PROPERTIES OUTPUT_NAME "hello")
```

这里 hello_shared 和 hello_static 名字必须不同，否则会忽略掉第二个库，所以使用 set_target_properties 命令重命名。

## add_executable

和 add_library 类似，将指定的源文件生成可执行文件。

## set_target_properties

```sh
set_target_properties(hello PROPERTIES VERSION 1.6.0. SOVERSION 1)
```

这条命令会生成三个文件：

```sh
libhello.so => libhello.so.1*
libhello.so.1 => libhello.so.1.6.0*
libhello.so.1.6.0
```

其中，libhello.so.1.6.0 为动态库的文件名（realname），libhello.so.1 为动态库的别名（soname），libhello.so 为动态库的链接名（linkname）。

## target_link_libraries

为 target 添加需要链接的共享库：

```sh
target_link_libraries(${PROJECT_NAME} opencv_imgcodecs)
```

## option

命令行参数

```sh
project(hello)

option(USE_XXX "option for use xxx" OFF)
if (USE_XXX)
    add_definitions(-DUSE_XXX)
    ...
endif()
cmake -DUSE_XXX=ON ..
```
