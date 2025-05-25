@echo off
setlocal enabledelayedexpansion

:: ������ʱ��������Ŀ¼������ʽ��output_YYMMDDhhmmss��
set "output=output_%date:~2,2%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%"
mkdir "%output%"

:: ��������Ŀ¼�µ�����PNG�ļ�
for /r "input" %%i in (*.png) do (
    :: ��ȡԴ�ļ�·�����滻Ϊ���·��
    set "sourcePath=%%~dpi"
    set "destPath=!sourcePath:input=%output%!"
    
    :: ����Ŀ��Ŀ¼����������ڣ�
    if not exist "!destPath!" (
        mkdir "!destPath!"
    )
    
    :: ִ��ASTC��ʽת��
    astcenc -cH "%%i" "!destPath!%%~ni.astc" 4x4 -exhaustive -silent
    echo ��ת��: %%~nxi
)

:: ��������Ϣ
echo ת����ɣ����Ŀ¼��%output%
pause

:: �����Ŀ¼
start "" "%output%"
