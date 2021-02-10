rem 生成3个随机字符串
@echo off
set n=3
rem n=3意思要生成3个随机字符串，如要10个修改n=10
setlocal enabledelayedexpansion
rem 开启变量延迟
set str=abcdefghijklmnopqrstuvwxyz0123456789
for /l %%a in (1,1,%n%) do call :slz "%%a"
rem for循环n次，因为每循环一次得到1个随机字符串，n次便是n个随机字符串
echo %random_str%

goto end
:slz
if "%~1"=="" goto:eof
set /a r=%random%%%36
rem 生成小于36的随机数(26个字母加10个数字等于36很好理解的)
set random_str=%random_str%!str:~%r%,1!
rem 字符变量截取及合并，这个要有一定的批处理功底才能看懂，（百度或google关键词“理解字符截取功能”）
EXIT /B 0

:end
pause