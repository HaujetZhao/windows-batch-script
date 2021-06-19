@echo off
setlocal enabledelayedexpansion

:: 作者：淳帅二代
:: 日期：2021 年 6 月 18 日
:: ***********************************************************************
:: 
:: 运行此脚本需要先确保安装有：，，
::    - ImageMagick (https://imagemagick.org/script/download.php)
::    - MozJPEG  （https://github.com/mozilla/mozjpeg/releases）
::    - pngquant  （https://pngquant.org/）
::    - libwebp   （https://developers.google.com/speed/webp/download）
:: “安装”的意思：将上述可执行文件的目录加到环境变量中
:: 
:: ***********************************************************************
:: 
:: 两种使用方法：
::    1. 将图片拖到此 bat脚本上进行处理
::    2. 将此脚本放到 %AppData%\Microsoft\Windows\SendTo
::       然后，就可以在文件上，右键，发送到，使用了
:: 
:: ***********************************************************************
:: 
:: 脚本的用处是，对符合以下条件的图片：
::   - 像素数大于 500w
::   - 宽高比小于 3
::   - 宽高比大于 0.3
:: 使用 ImageMagick 缩小分辨率到 500w 像素，保持原格式
:: 
:: 然后，不同格式区别处理：
::   - jpg 和 jpeg 格式使用 MozJPEG 的 cjpeg 压缩（质量默认，75）
::   - png 格式使用 pngquant 压缩（质量默认）
::   - webp 格式使用 libwebp 的 cwebp 压缩（质量默认，75）
:: 
:: 注意：对 jpg、jpeg、webp 格式反复压缩
::       不仅体积不会再有大幅下降
::       画质反而会一再下降
::       
::       而对 png 反复压缩，对画质不会再有影响
:: 
:: ***********************************************************************


for %%i in (%*) do (
	
	rem 确保格式符合 jpg、jpeg、png、webp
	if /i %%~xi==.jpg (
		set 格式正确=yes
	) else if /i %%~xi==.jpeg (
		set 格式正确=yes
	) else if /i %%~xi==.png (
		set 格式正确=yes
	) else if /i %%~xi==.webp (
		set 格式正确=yes
	)
	
	if /i !格式正确!==yes (

		echo 正在处理 %%i
		
		for /F "tokens=*" %%m in ('magick identify -format "%%[fx:w/h]" %%i') do set 宽高比=%%m
		echo 图片宽高比：!宽高比!
		
		if !宽高比! GEQ 0.3 (
			if !宽高比! LEQ 3 (
				rem 如果是正常宽高比，不是长截图、长拼图，则调整至 500 万像素
				echo 正在调整大小……
				magick %%i -resize "5000000@>" %%i
			)
		)
		
		rem 接下来再压缩
		echo 正在压缩……
		if /i %%~xi==.jpg (
			copy /y %%i "%temp%\cjpeg_temp.jpg"
			cjpeg -quality 70 -outfile %%i "%temp%\cjpeg_temp.jpg"
		) else if /i %%~xi==.jpeg (
			copy /y %%i "%temp%\cjpeg_temp.jpeg"
			cjpeg -quality 70 -outfile %%i "%temp%\cjpeg_temp.jpeg"
		) else if /i %%~xi==.png (
			copy /y %%i "%temp%\pngquant_temp.png"
			pngquant - < "%temp%\pngquant_temp.png" > %%i
		) else if /i %%~xi==.webp (
			cwebp -q 75 %%i -o %%i
		)
		
		echo=
	)
)



echo 所有图片处理完成! 

pause
