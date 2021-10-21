@setlocal enableextensions enabledelayedexpansion
echo off
chcp 65001
cls
MODE con: COLS=60 

set /a count=0
for /f  %%f in ('dir /B ') do (
echo !count!^) %%f
set arima[!count!]=%%f
set /a count+=1
)

echo.
:cho1
set /p yourArima=請選擇要匯入的資料夾到 arima資料夾:
for /f "delims=0123456789" %%a in ("%yourArima%") do if not "%%a"=="" echo 無效請重選 &goto cho1
if %yourArima% gtr %count% if %yourArima% equ 0 (
	 echo 無效請重選
	 call :cho1
	)
	
call echo 匯入 %%arima[%yourArima%]%% ...
call set ArrVar=%%arima[%yourArima%]%%
echo ArrVar %ArrVar%
copy  %ArrVar% arima

cd arima
dir /b
set /a count=1
for /f %%i in ('dir /b') do ( 
ren %%i location_!count!.csv  2>nul 
set /a count+=1
)

pause
