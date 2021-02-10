@echo off

:: 作者：淳帅二代
:: 日期：2021 年 2 月 10 日
:: 运行此脚本需要先确保安装有：pngquant

for %%i in (%*) do (
	if /i %%~xi==.png (
		move %%i "%temp%\temp.png"
		pngquant  - < "%temp%\temp.png" > %%i
	)
)

echo Mission complete! 

pause
