@echo off
setlocal enabledelayedexpansion

REM 检查是否提供了输入文件

if "%~dpnx1" == "" (
    echo 用法: %0 ^<视频文件路径^>
    pause
    exit /b
)

for %%i in (%*) do (
    REM 进入文件所在文件夹
    cd "%%~dpi"

    REM 提取输入视频文件的文件名和扩展名
    set "input_file=%%~dpnxi"
    set "file_name=%%~ni"
    set "file_extension=%%~xi"

    REM 构建字幕文件路径
    set "subtitle_file=!file_name!.srt"

    REM 检查字幕文件是否存在
    if not exist "!subtitle_file!" (
        echo 未找到字幕文件: !subtitle_file!
        pause
        exit /b
    )

    REM 构建输出文件路径
    set "output_file=!file_name!_with_subtitles.mp4"

    REM 使用 ffmpeg 将字幕嵌入到视频中
    ffmpeg -i "!input_file!" -vf subtitles="!subtitle_file!" -c:a copy "!output_file!"

    echo 字幕已成功嵌入到视频中，输出文件为: !output_file!

    endlocal
)


