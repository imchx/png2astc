@echo off
setlocal enabledelayedexpansion

:: 创建带时间戳的输出目录名（格式：output_YYMMDDhhmmss）
set "output=output_%date:~2,2%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%"
mkdir "%output%"

:: 遍历输入目录下的所有PNG文件
for /r "input" %%i in (*.png) do (
    :: 提取源文件路径并替换为输出路径
    set "sourcePath=%%~dpi"
    set "destPath=!sourcePath:input=%output%!"
    
    :: 创建目标目录（如果不存在）
    if not exist "!destPath!" (
        mkdir "!destPath!"
    )
    
    :: 执行ASTC格式转换
    astcenc -cH "%%i" "!destPath!%%~ni.astc" 4x4 -exhaustive -silent
    echo 已转换: %%~nxi
)

:: 输出结果信息
echo 转换完成！输出目录：%output%
pause

:: 打开输出目录
start "" "%output%"
