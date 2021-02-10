@echo off
echo "开始处理..."

for /R %%i in (*.gif) do (
  gifsicle --batch --resize-width 480 -i "%%i"
  echo "成功"
)