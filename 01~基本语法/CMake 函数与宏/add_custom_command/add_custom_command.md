# add_custom_command

和 install 相比，add_custom_command 更加灵活，下面展示一个用 add_custom_command 做拷贝的示例：

```sh
add_custom_command(TARGET ${target_name} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${target_name}>
        ${path/to/dst})
```
