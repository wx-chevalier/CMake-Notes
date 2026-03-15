# install

## install 命令

install 用于指定在安装时运行的规则。它可以用来安装很多内容，可以包括目标二进制、动态库、静态库以及文件、目录、脚本等：

```sh
install(TARGETS <target>... [...])
install({FILES | PROGRAMS} <file>... [...])
install(DIRECTORY <dir>... [...])
install(SCRIPT <file> [...])
install(CODE <code> [...])
install(EXPORT <export-name> [...])
```

有时候，也会用到一个非常有用的变量 CMAKE_INSTALL_PREFIX，用于指定 cmake install 时的相对地址前缀。用法如：

```sh
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
```

目标文件的安装：

```sh
install(TARGETS targets... [EXPORT <export-name>]
        [[ARCHIVE|LIBRARY|RUNTIME|OBJECTS|FRAMEWORK|BUNDLE|
          PRIVATE_HEADER|PUBLIC_HEADER|RESOURCE]
         [DESTINATION <dir>]
         [PERMISSIONS permissions...]
         [CONFIGURATIONS [Debug|Release|...]]
         [COMPONENT <component>]
         [NAMELINK_COMPONENT <component>]
         [OPTIONAL] [EXCLUDE_FROM_ALL]
         [NAMELINK_ONLY|NAMELINK_SKIP]
        ] [...]
        [INCLUDES DESTINATION [<dir> ...]]
        )
```

参数中的 TARGET 可以是很多种目标文件，最常见的是通过 ADD_EXECUTABLE 或者 ADD_LIBRARY 定义的目标文件，即可执行二进制、动态库、静态库：

| 目标文件       | 内容                      | 安装目录变量                | 默认安装文件夹 |
| -------------- | ------------------------- | --------------------------- | -------------- |
| ARCHIVE        | 静态库                    | ${CMAKE_INSTALL_LIBDIR}     | lib            |
| LIBRARY        | 动态库                    | ${CMAKE_INSTALL_LIBDIR}     | lib            |
| RUNTIME        | 可执行二进制文件          | ${CMAKE_INSTALL_BINDIR}     | bin            |
| PUBLIC_HEADER  | 与库关联的 PUBLIC 头文件  | ${CMAKE_INSTALL_INCLUDEDIR} | include        |
| PRIVATE_HEADER | 与库关联的 PRIVATE 头文件 | ${CMAKE_INSTALL_INCLUDEDIR} | include        |

为了符合一般的默认安装路径，如果设置了 DESTINATION 参数，推荐配置在安装目录变量下的文件夹。

```sh
INSTALL(TARGETS myrun mylib mystaticlib
       RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
       LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
       ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
```

上面的例子会将：可执行二进制 myrun 安装到${CMAKE_INSTALL_BINDIR}目录，动态库libmylib.so安装到${CMAKE_INSTALL_LIBDIR}目录，静态库 libmystaticlib.a 安装到${CMAKE_INSTALL_LIBDIR}目录。

该命令的其他一些参数的含义：

- DESTINATION：指定磁盘上要安装文件的目录；
- PERMISSIONS：指定安装文件的权限。**有效权限是 OWNER_READ，OWNER_WRITE，OWNER_EXECUTE，GROUP_READ，GROUP_WRITE，GROUP_EXECUTE，WORLD_READ，WORLD_WRITE，WORLD_EXECUTE，SETUID 和 SETGID**；
- CONFIGURATIONS：指定安装规则适用的构建配置列表(DEBUG 或 RELEASE 等)；
- EXCLUDE_FROM_ALL：指定该文件从完整安装中排除，仅作为特定于组件的安装的一部分进行安装；
- OPTIONAL：如果要安装的文件不存在，则指定不是错误。

注意一下 CONFIGURATIONS 参数，此选项指定的值仅适用于此选项之后列出的选项：例如，要为调试和发布配置设置单独的安装路径，请执行以下操作：

```sh
install(TARGETS target
        CONFIGURATIONS Debug
        RUNTIME DESTINATION Debug/bin)
install(TARGETS target
        CONFIGURATIONS Release
        RUNTIME DESTINATION Release/bin)
```

也就是说，DEBUG 和 RELEASE 版本的 DESTINATION 安装路径不同，那么 DESTINATION 必须在 CONFIGUATIONS 后面。

## 普通文件的安装

```sh
install(<FILES|PROGRAMS> files...
        TYPE <type> | DESTINATION <dir>
        [PERMISSIONS permissions...]
        [CONFIGURATIONS [Debug|Release|...]]
        [COMPONENT <component>]
        [RENAME <name>] [OPTIONAL] [EXCLUDE_FROM_ALL])
```

FILES|PROGRAMS 若为相对路径给出的文件名，将相对于当前源目录进行解释。其中，FILES 为普通的文本文件，PROGRAMS 指的是非目标文件的可执行程序(如脚本文件)。如果未提供 PERMISSIONS 参数，默认情况下，普通的文本文件将具有 OWNER_WRITE，OWNER_READ，GROUP_READ 和 WORLD_READ 权限，即 644 权限；而非目标文件的可执行程序将具有 OWNER_EXECUTE, GROUP_EXECUTE,和 WORLD_EXECUTE，即 755 权限。

其中，不同的 TYPE，cmake 也提供了默认的安装路径，如下表：

| TYPE 类型   | 安装目录变量                   | 默认安装文件夹 |
| ----------- | ------------------------------ | -------------- |
| BIN         | ${CMAKE_INSTALL_BINDIR}        | bin            |
| SBIN        | ${CMAKE_INSTALL_SBINDIR}       | sbin           |
| LIB         | ${CMAKE_INSTALL_LIBDIR}        | lib            |
| INCLUDE     | ${CMAKE_INSTALL_INCLUDEDIR}    | include        |
| SYSCONF     | ${CMAKE_INSTALL_SYSCONFDIR}    | etc            |
| SHAREDSTATE | ${CMAKE_INSTALL_SHARESTATEDIR} | com            |
| LOCALSTATE  | ${CMAKE_INSTALL_LOCALSTATEDIR} | var            |
| RUNSTATE    | ${CMAKE_INSTALL_RUNSTATEDIR}   | /run           |
| DATA        | ${CMAKE_INSTALL_DATADIR}       |                |
| INFO        | ${CMAKE_INSTALL_INFODIR}       | /info          |
| LOCALE      | ${CMAKE_INSTALL_LOCALEDIR}     | /locale        |
| MAN         | ${CMAKE_INSTALL_MANDIR}        | /man           |
| DOC         | ${CMAKE_INSTALL_DOCDIR}        | /doc           |

请注意，某些类型的内置默认值使用`DATAROOT`目录作为前缀，以`CMAKE_INSTALL_DATAROOTDIR`变量值为内容。

该命令的其他一些参数的含义：

- DESTINATION：指定磁盘上要安装文件的目录；
- PERMISSIONS：指定安装文件的权限。**有效权限是 OWNER_READ，OWNER_WRITE，OWNER_EXECUTE，GROUP_READ，GROUP_WRITE，GROUP_EXECUTE，WORLD_READ，WORLD_WRITE，WORLD_EXECUTE，SETUID 和 SETGID**；
- CONFIGURATIONS：指定安装规则适用的构建配置列表(DEBUG 或 RELEASE 等)；
- EXCLUDE_FROM_ALL：指定该文件从完整安装中排除，仅作为特定于组件的安装的一部分进行安装；
- OPTIONAL：如果要安装的文件不存在，则指定不是错误；
- RENAME：指定已安装文件的名称，该名称可能与原始文件不同。仅当命令安装了单个文件时，才允许重命名。

## 目录的安装

```sh
install(DIRECTORY dirs...
        TYPE <type> | DESTINATION <dir>
        [FILE_PERMISSIONS permissions...]
        [DIRECTORY_PERMISSIONS permissions...]
        [USE_SOURCE_PERMISSIONS] [OPTIONAL] [MESSAGE_NEVER]
        [CONFIGURATIONS [Debug|Release|...]]
        [COMPONENT <component>] [EXCLUDE_FROM_ALL]
        [FILES_MATCHING]
        [[PATTERN <pattern> | REGEX <regex>]
         [EXCLUDE] [PERMISSIONS permissions...]] [...])
```

该命令将一个或多个目录的内容安装到给定的目的地，目录结构被逐个复制到目标位置。每个目录名称的最后一个组成部分都附加到目标目录中，但是可以使用后跟斜杠来避免这种情况，因为它将最后一个组成部分留空。这是什么意思呢？

比如，`DIRECTORY`后面如果是`abc`意味着`abc`这个目录会安装在目标路径下，`abc/`意味着`abc`这个目录的内容会被安装在目标路径下，而`abc`目录本身却不会被安装。即，**如果目录名不以/结尾，那么这个目录将被安装为目标路径下的 abc，如果目录名以/结尾，代表将这个目录中的内容安装到目标路径，但不包括这个目录本身**。

`FILE_PERMISSIONS`和`DIRECTORY_PERMISSIONS`选项指定对目标中文件和目录的权限。如果指定了`USE_SOURCE_PERMISSIONS`而未指定`FILE_PERMISSIONS`，则将从源目录结构中复制文件权限。如果未指定权限，则将为文件提供在命令的`FILES`形式中指定的默认权限(`644`权限)，而目录将被赋予在命令的`PROGRAMS`形式中指定的默认权限(`755`权限)。

可以使用`PATTERN`或`REGEX`选项以精细的粒度控制目录的安装，可以**指定一个通配模式或正则表达式以匹配输入目录中遇到的目录或文件**。**PATTERN 仅匹配完整的文件名，而 REGEX 将匹配文件名的任何部分，但它可以使用/和$模拟 PATTERN 行为**。

**某些跟随 PATTERN 或 REGEX 表达式后的参数，仅应用于满足表达式的文件或目录**。如：`EXCLUDE`选项将跳过匹配的文件或目录。`PERMISSIONS`选项将覆盖匹配文件或目录的权限设置。

例如：

```cmake
install(DIRECTORY icons scripts/ DESTINATION share/myproj
        PATTERN "CVS" EXCLUDE
        PATTERN "scripts/*"
        PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
                    GROUP_EXECUTE GROUP_READ)
```

这条命令的执行结果是：将`icons`目录安装到`share/myproj`，将`scripts/`中的内容安装到`share/myproj`，两个目录均不包含目录名为`CVS`的子目录，对于`scripts/*`的文件指定权限为 OWNER_EXECUTE，OWNER_WRITE，OWNER_READ，GROUP_EXECUTE，GROUP_READ。

## 安装时脚本的运行

有时候需要在`install`的过程中打印一些语句，或者执行一些`cmake`指令：

```cmake
install([[SCRIPT <file>] [CODE <code>]]
        [COMPONENT <component>] [EXCLUDE_FROM_ALL] [...])
```

`SCRIPT`参数将在安装过程中**调用给定的 CMake 脚本文件(即.cmake 脚本文件)**，如果脚本文件名是相对路径，则将相对于当前源目录进行解释。`CODE`参数将在安装过程中调用给定的`CMake`代码。将代码**指定为双引号字符串内的单个参数**。

例如：

```cmake
install(CODE "MESSAGE(\"Sample install message.\")")
```

这条命令将会在`install`的过程中执行`cmake`代码，打印语句。
