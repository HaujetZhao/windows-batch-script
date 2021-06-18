@echo off

:: 作者：淳帅二代
:: 日期：2021 年 6 月 18 日
:: 运行此脚本需要先确保安装有：ImageMagick

for %%i in (%*) do (
	if /i %%~xi==.jpg (
	    magick %%i -resize "5000000@" -quality 80 %%i
	)
)

echo Mission complete! 

pause
