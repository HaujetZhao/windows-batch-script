@echo off
setlocal enabledelayedexpansion

:: 作者：Haujet Zhao
:: 日期：2021 年 2 月 10 日
:: 运行此脚本需要先确保安装有：FFmpeg

for %%i in (%*) do (
	if /i %%~xi neq .mp4 (
		set 输入文件路径=%%~dpi
		set 输入文件名称=%%~ni
		set 输入文件拓展名=%%~xi
		
		set 全局选项=-y -hide_banner
		
		set 输入文件选项=-i
		set 输入文件="%%~i"
		
		set 输出文件选项=-c copy
		set 输出文件名="!输入文件路径!!输入文件名称!.mp4"
		
		set 命令=ffmpeg !全局选项! !输入文件选项! !输入文件! !输出文件选项! !输出文件名!
		
		echo=
		echo !命令!
		echo=
		
		!命令!
	)
)

echo Mission complete! 

pause
