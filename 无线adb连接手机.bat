@echo off
adb disconnect
REM 待处理的字符串
set command=adb shell "ip address | grep inet | grep 192 | grep -v inet6 | grep -v 127"
for /F "tokens=*" %%i in ('%command%') do set str="%%i"
REM set str="inet 192.168.1.137/24 brd 192.168.1.255 scope global wlan0"
 
REM FOR语句是按行进行遍历，也就是一行一次循环，对于我们来说，只有一行字符串，
REM 这个FOR循环肯定只进入一次。而我们是要对字符串进行空格分割后再处理。因此这
REM 里用GOTO语句来实现循环。而FOR语句只需看成是一条语句，这条语句实现了这样的
REM 功能：将字符串分割成两一部分，一部分是第一个空格前的字串，另一部分是剩余的
REM 字串（tokens=1,*）。第一部分保存在 a 变量中，第二部分保存在 b 变量中，这
REM 个 b 是自动的。
for /f "tokens=2,*" %%a in (%str%) do (
    REM 这里可以替换成自己的处理程序，现在只是简单地显示值
    REM set a = "%%a"
    REM echo %a%
    REM 将剩余字符串存在b里面
    set str="%%a"
)
echo str = %str% 
for /f "delims=/ tokens=1,*" %%a in (%str%) do (
    REM 这里可以替换成自己的处理程序，现在只是简单地显示值
    REM set a = "%%a"
    REM echo %a%
    REM 将剩余字符串赋值给str变量
    set str=%%a
)
echo 找到局域网IP = %str% 

adb tcpip 6666
set _ip=%str%:6666
set command=adb connect %_ip%
for /F "tokens=*" %%i in ('%command%') do set RESULT="%%i"

echo %RESULT% |findstr "connected" >nul

if %errorlevel% equ 0 (
echo "成功连接到%_ip%"
) else (
echo "连接到%_ip%失败！！"
pause
)