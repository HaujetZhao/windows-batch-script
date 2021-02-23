@echo off
setlocal enabledelayedexpansion

:: 作者：Haujet Zhao
:: 日期：2021 年 2 月 23 日
:: 运行此脚本需要先确保安装有：FFmpeg
:: 作用：使用 ffmpeg 批处理文件。
:: 用法：将要处理的文件拖动到本 bat 文件上，松手，然后根据提示输入参数
::      然后脚本会根据这些参数依次处理传入的文件。

echo 输入选项：
set /p 输入选项=

echo 输出选项（默认 -c copy）：
set /p 输出选项=
if not defined 输出选项 (
    set 输出选项=-c copy
)

echo 输出单独到文件夹：
set /p 输出单独文件夹名=

echo 输出主文件名后缀：
set /p 输出主文件名后缀=

echo 输出拓展名（默认 mp4）：
set /p 输出拓展名=
if not defined 输出拓展名 (
    set 输出拓展名=mp4
)

for %%i in (%*) do (
    set 输入路径=\\?\%%~dpi
    set 输入主文件名=%%~ni
    set 输入拓展名=%%~xi
    
    set 全局选项=-y -hide_banner
    
    set 输入选项=-i !输入选项!
    set 输入路径名="\\?\%%~i"
    
    set 输出主文件名=!输入主文件名!!输出主文件名后缀!
    
    if defined 输出单独文件夹名 (
        set 输出路径=!输入路径!!输出单独文件夹名!\
    ) else (
        set 输出路径=!输入路径!
    )
    
    if not exist !输出路径! (
        mkdir !输出路径!
    )
    
    set 输出路径名="!输出路径!!输出主文件名!.!输出拓展名!"
    
    set 命令=ffmpeg !全局选项! !输入选项! !输入路径名! !输出选项! !输出路径名!
    
    echo=
    echo !命令!
    echo=
    
    !命令!
)

pause