setlocal enabledelayedexpansion
@echo off

:: 作者：淳帅二代
:: 日期：2021 年 6 月 18 日
:: 运行此脚本需要先确保安装有：ImageMagick
:: 
:: 将图片拖到此脚本上进行处理
:: 对符合以下条件的图片：
::   - 格式为 jpg 或 jpeg
::   - 像素数大于 500w
::   - 宽高比小于 3
::   - 宽高比大于 0.3
:: 缩小分辨率到 500w 像素，并且按质量 50 压缩。

for %%i in (%*) do (
	
	if /i %%~xi==.jpg (
		set 格式正确=yes
	) else if /i %%~xi==.jpeg (
		set 格式正确=yes
	) else (
		set 格式正确=noo
	)
	
	if /i !格式正确!==yes (
	
		for /F "tokens=*" %%m in ('magick identify -format "%%[fx:w/h]" %%i') do set 宽高比=%%m
		echo 正在处理 %%i
		echo 图片宽高比：!宽高比!
		
		set 宽高比正常=no
		if !宽高比! GEQ 3 (
			if !宽高比! LEQ 3 (
				set 宽高比正常=yes
			)
		)
		
		if /i !宽高比正常!=yes (
			magick %%i -resize "5000000@>" -quality 50 %%i
		) else (
			magick %%i -resize "2000x2000^>" -quality 50 %%i
		)
		
		echo=
	)
)

echo Mission complete! 

pause
