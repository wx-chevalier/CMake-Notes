# find_package

find_package 的作用就是寻找第三方模块的头文件目录和库文件路径，并将其设为变量，返回提供给 CMakeLists.txt 其他部分使用。

1.  find_package 首先会寻找并执行模块相关的 `.cmake` 文件。寻找顺序如下：

    1.  在寻找模块的时候显式指定了模块目录：`find_package(${module_name} REQUIRED PATHS ${module_dir})`
    2.  在 `${module_name}_DIR` 变量中指定了模块目录
    3.  查找路径的根目录，默认查找目录如下：
        1.  `${module_name}_DIR`
        2.  `MAKE_PREFIX_PATH`
        3.  `CMAKE_FRAMEWORK_PATH`
        4.  `CMAKE_APPBUNDLE_PATH`
        5.  `PATH`：如果以 bin 或 sbin 结尾，则自动回退到上一级目录
    4.  检查上述目录下的这些目录：
        1.  `(lib/${arch}|lib|share)/cmake/${module_name}*/`
        2.  `(lib/${arch}|lib|share)/${module_name}*/`
        3.  `(lib/${arch}|lib|share)/${module_name}*/(cmake|CMake)/`
    5.  寻找并执行 `${module_name}Config.cmake` 或 `Find${module_name}.cmake` 脚本

2.  find_package 然后会设置以下几个变量：

- `${module_name}_FOUND`：是否找到该模块
- `${module_name}_INCLUDE_DIR`：模块头文件目录
- `${module_name}_LIBRARY` 或 `${module_name}_LIBRARIES`：模块库文件路径

以 LibTorch 为例展示一个例子：

```sh
find_package(Torch REQUIRED)  # REQUIRED 表明这个模块是必需的，如果找不到就报错
add_executable(torch_test "torch_test.cpp")
include_directories(${TORCH_INCLUDE_DIRS})
target_link_libraries(torch_test ${TORCH_LIBRARIES})
```
