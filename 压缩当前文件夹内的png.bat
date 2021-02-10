@echo off
echo "开始处理..."

for /R %%i in (*.png) do (
  move "%%i" "%temp%\temp.png"
  pngquant  - < "%temp%\temp.png" > "%%i"
  echo "成功"
)

pause