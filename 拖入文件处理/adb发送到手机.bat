@echo off
setlocal enabledelayedexpansion

:: 作者：Haujet Zhao
:: 日期：2021 年 2 月 10 日
:: 运行此脚本需要先确保安装有：adb

REM 路径后面记得不要加斜杠
set 目标路径=/sdcard/_电脑传输

echo 目标路径：%目标路径%
echo=

set 有连接=False
for /F "tokens=* skip=1" %%i in ('adb devices') do set 有连接=True

set n=10
set str=abcdefghijklmnopqrstuvwxyz0123456789
for /l %%a in (1,1,%n%) do call :slz "%%a"

if  %有连接%==True (
	for %%i in (%*) do (
		set 原来名字=%%~nxi
		set 正经路径=%目标路径%/!原来名字!
		
		set 随机文件名路径=%目标路径%/!random_str!
		adb push %%i "!随机文件名路径!"
		adb shell "mv ""!随机文件名路径!"" ""!正经路径!"""
	)
) else (
	echo 无连接
)

echo=

rem ============下面是函数区==============================
goto end

:slz
if "%~1"=="" goto:eof
set /a r=%random% %% 36
set random_str=%random_str%!str:~%r%,1!
EXIT /B 0

:end
pause