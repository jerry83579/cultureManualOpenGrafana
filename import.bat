@setlocal enableextensions enabledelayedexpansion
echo off
chcp 65001
cls
MODE con: COLS=60 

:displayFile
set /a count=0
for /f  %%f in ('dir /B ') do (
echo !count!^) %%f
set arima[!count!]=%%f
set /a count+=1
)

echo.

:cho1
set /a count=1
If not exist "arima" (
    mkdir arima
) 
set /p yourArima=請選擇要匯入的資料夾到 arima的資料夾:
for /f "delims=0123456789" %%a in ("%yourArima%") do if not "%%a"=="" echo 無效請重選 &goto cho1
if %yourArima% gtr %count% if %yourArima% equ 0 (
	 echo 無效請重選
	 call :cho1
	)
	
call echo 匯入 %%arima[%yourArima%]%% ...
call set ArrVar=%%arima[%yourArima%]%%
copy  %ArrVar% arima
cd arima
::刪除檔名帶有空格的空格
set "str= "
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")


:amountRenameArima
::計算檔案數量
set /a arimaOrder
for /f "tokens=*" %%i in ('dir /s^|find "File(s)" ') do ( set amount=%%i)
for /f %%f in ("%amount%") do (set arimaAmount=%%f)
echo 數量為%arimaAmount%
::更改黨名
for /f %%i in ('dir /b') do ( 
set arimaOrder[!count!]=%%i
ren %%i !count!.csv  2>nul 
set /a count+=1
)
echo 匯入完成

cd ..
echo.

:displayFile
set /a count=0
for /f  %%f in ('dir /B ') do (
echo !count!^) %%f
set chebychev[!count!]=%%f
set /a count+=1
)
echo.

:cho2
set /a count=1
If not exist "chebychev" (
    mkdir chebychev
) 
set /p yourChebychev=請選擇要匯入的資料夾到 chebychev的資料夾:
for /f "delims=0123456789" %%a in ("%yourArima%") do if not "%%a"=="" echo 無效請重選 &goto cho2
if %yourChebychev% gtr %count% if %yourChebychev% equ 0 (
	 echo 無效請重選
	 call :cho2
	)
	
call echo 匯入 %%chebychev[%yourChebychev%]%% ...
call set copy=%%chebychev[%yourChebychev%]%%
copy  %copy% chebychev

cd chebychev
set "str= "
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")

dir /b

:amountRenameChebychev
::計算檔案數量
set /a chebychevOrder
for /f "tokens=*" %%i in ('dir /s^|find "File(s)" ') do ( set amount=%%i)
for /f %%f in ("%amount%") do (set chebychevAmount=%%f)
echo 數量為%chebychevAmount%
::更改黨名
for /f %%i in ('dir /b') do ( 
set chebychevOrder[!count!]=%%i
ren %%i !count!.csv  2>nul 
set /a count+=1
)
echo 匯入完成
cd ..
echo.

:displayFile
set /a count=0
for /f  %%f in ('dir /B ') do (
echo !count!^) %%f
set initialize[!count!]=%%f
set /a count+=1
)
echo.

:cho3
set /a count=1
If not exist "initialize" (
    mkdir initialize
) 
set /p yourInitialize=請選擇要匯入的資料夾到 initialize的資料夾:
for /f "delims=0123456789" %%a in ("%yourInitialize%") do if not "%%a"=="" echo 無效請重選 &goto cho3
if %yourInitialize% gtr %count% if %yourInitialize% equ 0 (
	 echo 無效請重選
	 call :cho3
	)
	
call echo 匯入 %%initialize[%yourInitialize%]%% ...
call set copy=%%initialize[%yourInitialize%]%%
copy  %copy% initialize

cd initialize
set "str= "
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")

dir /b

:amountRenameInitialize
::計算檔案數量
set /a initializeOrder
for /f "tokens=*" %%i in ('dir /s^|find "File(s)" ') do ( set amount=%%i)
for /f %%f in ("%amount%") do (set initializeAmount=%%f)
echo 數量為%initializeAmount%
::更改黨名
for /f %%i in ('dir /b') do ( 
set initializeOrder[!count!]=%%i
ren %%i !count!.csv  2>nul 
set /a count+=1
)
echo 匯入完成

cd ..
echo.

:callmergepy
if %chebychevAmount% == %arimaAmount% if %arimaAmount% == %initializeAmount% (
mkdir outcome 2> NUL
echo.
echo 合併的檔案順序
echo Arima:
for /l %%f in (1,1,%chebychevAmount%) do ( call echo %%arimaOrder[%%f]%% )
echo.
echo Chebychev:
for /l %%f in (1,1,%chebychevAmount%) do ( call echo %%chebychevOrder[%%f]%% )
echo.
echo Initialize:
for /l %%f in (1,1,%chebychevAmount%) do ( call echo %%initializeOrder[%%f]%% )

) else (
 echo oops, has problem 
 )

cd python
python home.py %chebychevAmount% 





pause
