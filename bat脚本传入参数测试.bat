@echo off

echo %%1     完整路径,带引号    %1
echo %%~1    不带引号路径       %~1
echo %%~f1   完全合格路径       %~f1 
echo %%~d1   驱动器号           %~d1 
echo %%~p1   路径               %~p1 
echo %%~n1   文件名             %~n1 
echo %%~x1   文件扩展名         %~x1 
echo %%~s1   含有短名           %~s1 
echo %%~a1   文件属性           %~a1 
echo %%~t1   日期/时间          %~t1 
echo %%~z1   文件大小           %~z1 
echo %%~$PATH:1 扩充环境变量  %~$PATH:1

for %%i in (%*) do (
	echo 盘符和路径： %%~dpi
)

pause