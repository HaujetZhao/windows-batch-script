for %%i in (%*) do (
	magick convert "%%i" -resize 128x128 "%%~dpi%%~ni.ico"
	magick convert "%%i" -resize 128x128 "%%~dpi%%~ni.icns"
)

