@echo off
setlocal enabledelayedexpansion

:: 作者：Haujet Zhao
:: 日期：2021 年 2 月 11 日
:: 作用：将本文件夹内的 mp4 文件转为 mp3 音频

:: 运行此脚本需要先确保安装有：FFmpeg


for /R %%i in (*.mp4) do (
	set 输入文件路径=%%~dpi
	set 输入文件名称=%%~ni
	set 输入文件拓展名=%%~xi
	
	set 全局选项=-y -hide_banner
	
	set 输入文件选项=-i
	set 输入文件="%%~i"
	
	set 输出文件选项=
	
	set 输出到单独文件夹=output
	set 输出文件名称=!输入文件名称!
	
	if defined 输出到单独文件夹 (
		set 输出文件夹=!输入文件路径!!输出到单独文件夹!\
		echo yes
	) else (
		set 输出文件夹=!输入文件路径!
		echo no
	)
	
	if not exist !输出文件夹! (
		mkdir !输出文件夹!
	)
	
	set 输出文件路径="!输出文件夹!!输出文件名称!.mp3"
	
	set 命令=ffmpeg !全局选项! !输入文件选项! !输入文件! !输出文件选项! !输出文件路径!
	
	echo=
	echo !命令!
	echo=
	
	!命令!
)

echo Mission complete! 

pause
