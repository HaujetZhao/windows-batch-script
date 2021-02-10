@echo off
setlocal enabledelayedexpansion

echo 开始处理（Start Processing）

for /R %%i in (*.mp4) do (
	set ext=_transcoded.mp4
	ffmpeg -hide_banner -i "%%~fi" -c copy -metadata:s:v:0 rotate=90 "%%~di%%~pi%%~ni!ext!"
)

echo . && echo . && echo . && echo 完成（Finished） && echo . && echo . && echo . 
pause

