setlocal enabledelayedexpansion
@echo off

:: 作者：淳帅二代
:: 日期：2021 年 6 月 18 日
:: 运行此脚本需要先确保安装有：ImageMagick
:: 这个脚本会把拖入的像素数大于 500w 的 jpg 和 jpeg 图片
:: 缩小分辨率到 500w 像素，并且按质量 80 压缩。

for %%i in (%*) do (
	
	if /i %%~xi==.jpg (
		set 是否处理=yes
	) else if /i %%~xi==.jpeg (
		set 是否处理=yes
	) else (
		set 是否处理=noo
	)
	
	if /i !是否处理!==yes (
		echo 正在处理 %%i
		magick %%i -resize "5000000@>" -quality 80 %%i
	)
)

echo Mission complete! 

pause
