# target_sources

target_sources 用于向 target 中追加源文件，例如：

```
add_library(my_lib "")  # 这里的 "" 不能省略

target_sources(my_lib
  PRIVATE
    ${CMAKE_CURRENT_DIR}/foo.cpp
    ${CMAKE_CURRENT_DIR}/bar.cpp
  PUBLIC
    ${CMAKE_CURRENT_DIR}/foo.h
    ${CMAKE_CURRENT_DIR}/bar.h
  )
```

注：

- 如果在根目录通过 add_library 定义了一个 target，也可以在子目录中用 target_sources 命令往这个 target 中追加源文件
- C++ 的源文件指定为 PRIVATE，是因为源文件只是在构建库文件时使用，头文件指定为 PUBLIC 是因为构建库文件和使用库文件时都会使用
