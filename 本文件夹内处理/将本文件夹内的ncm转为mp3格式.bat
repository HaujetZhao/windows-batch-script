@echo off
setlocal enabledelayedexpansion

:: 作者：Haujet Zhao
:: 日期：2021 年 2 月 14 日
:: 作用：将本文件夹内的 ncm 文件转为 mp3 音频
::       ，转换完成后原有的 ncm 文件会被删除

:: 运行此脚本需要先确保安装有：Python、ncmdump

:: ncmdump 源码地址：https://github.com/anonymous5l/ncmdump
:: ncmdump Python 实现的源码仓库：https://github.com/nondanee/ncmdump

:: pip 安装 ncmdump 命令：pip install git+https://github.com/anonymous5l/ncmdump.git

:: 其实是可以使用 ncmdump 的 -d 选项删除输入文件的
:: 但是为了方便改写脚本适应其它程序
:: 这里使用手动删除输入文件的方式

set 转化完成后删除原文件=True

for /R %%i in (*.ncm) do (
	set 输入文件路径=%%~dpi
	set 输入文件名=%%~ni
	set 输入文件拓展名=%%~xi
	
	set 全局选项=
	
	set 输入文件="%%~i"
	
	set 命令=ncmdump !全局选项! !输入文件! 
	
	echo=
	echo !命令!
	
	!命令!
	
	if %转化完成后删除原文件% == True (
		echo 删除 !输入文件!
		del !输入文件!
	)
)

echo Mission complete! 

pause
