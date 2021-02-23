@echo off

:: 作者：淳帅二代
:: 日期：2021 年 2 月 12 日
:: 运行此脚本需要先确保安装有：optipng

for %%i in (%*) do (
	if /i %%~xi==.png (
		optipng -o2 %%i
	)
)

echo Mission complete! 

pause
