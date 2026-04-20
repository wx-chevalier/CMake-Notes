# execute_process

如果 OUTPUT_VARIABLE 和 ERROR_VARIABLE 变量名相同，它们的输出将按照产生顺序被合并。

```sh
execute_process(
    COMMAND <command>
    WORKING_DIRECTORY <directory>
    RESULT_VARIABLE res_var # 子进程返回码或者错误描述字符串
    OUTPUT_VARIABLE out_var # 标准输出
    ERROR_VARIABLE err_var # 标准错误
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_STRIP_TRAILING_WHITESPACE)
```
