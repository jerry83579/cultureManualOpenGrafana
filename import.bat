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
copy  %ArrVar% arima

cd arima
set /a count=1
for /f %%i in ('dir /b') do ( 
ren %%i location_!count!.csv  2>nul 
set /a count+=1
)
echo 匯入完成
cd ..
echo.

set /a count=0
for /f  %%f in ('dir /B ') do (
echo !count!^) %%f
set chebychev[!count!]=%%f
set /a count+=1
)
echo.

:cho2
set /p yourChebychev=請選擇要匯入的資料夾到 chebychev資料夾:
for /f "delims=0123456789" %%a in ("%yourArima%") do if not "%%a"=="" echo 無效請重選 &goto cho2
if %yourChebychev% gtr %count% if %yourChebychev% equ 0 (
	 echo 無效請重選
	 call :cho2
	)
	
call echo 匯入 %%chebychev[%yourChebychev%]%% ...
call set copy=%%chebychev[%yourChebychev%]%%
echo copy %copy%
copy  %copy% chebychev

cd chebychev
dir /b
set /a count=1
for /f %%i in ('dir /b') do ( 
ren %%i location_!count!.csv  2>nul 
set /a count+=1
)
echo 匯入完成
cd ..
echo.

set /a count=0
for /f  %%f in ('dir /B ') do (
echo !count!^) %%f
set initialize[!count!]=%%f
set /a count+=1
)
echo.

:cho3
set /p yourInitialize=請選擇要匯入的資料夾到 initialize資料夾:
for /f "delims=0123456789" %%a in ("%yourInitialize%") do if not "%%a"=="" echo 無效請重選 &goto cho3
if %yourInitialize% gtr %count% if %yourInitialize% equ 0 (
	 echo 無效請重選
	 call :cho3
	)
	
call echo 匯入 %%initialize[%yourInitialize%]%% ...
call set copy=%%initialize[%yourInitialize%]%%
echo copy %copy%
copy  %copy% initialize

cd initialize
dir /b
set /a count=1
for /f %%i in ('dir /b') do ( 
ren %%i location_!count!.csv  2>nul 
set /a count+=1
)
echo 匯入完成
cd ..
echo.

pause
