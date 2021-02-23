@echo off
setlocal enabledelayedexpansion

:: 作者：Haujet Zhao
:: 日期：2021 年 2 月 11 日
:: 运行此脚本需要先确保安装有：FFmpeg

for %%i in (%*) do (
	if /i %%~xi neq .mp4 (
		set 输入路径=%%~dpi
		set 输入主文件名=%%~ni
		set 输入拓展名=%%~xi
		
		set 全局选项=-y -hide_banner
		
		set 输入选项=-i
		set 输入路径名="%%~i"
		
		set 输出文件选项=-c copy
		
		set 输出单独文件夹名=
		
		set 输出主文件名=!输入主文件名!
		
		if defined 输出单独文件夹名 (
			set 输出路径=!输入路径!!输出单独文件夹名!\
			echo yes
		) else (
			set 输出路径=!输入路径!
			echo no
		)
		
		if not exist !输出路径! (
			mkdir !输出路径!
		)
		
		set 输出路径名="!输出路径!!输出主文件名!.mp4"
		
		set 命令=ffmpeg !全局选项! !输入选项! !输入路径名! !输出文件选项! !输出路径名!
		
		echo=
		echo !命令!
		echo=
		
		!命令!
	)
)

echo Mission complete! 

pause
