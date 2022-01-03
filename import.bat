@setlocal enableextensions enabledelayedexpansion
echo off
chcp 65001
cls
MODE con: COLS=60 

If not exist outcome (
    mkdir outcome
)

::讀取mainConfig檔判斷method是lstm還是arima
cd python
for /f %%i in (mainConfig.py) do (
  if  "%%i"=="method='lstm'" ( set method=lstm)
  if  "%%i"=="method='arima'" ( set method=arima)
)
cd ..

::呈現資料夾
:displayFile

set /a count=0
for /f  %%f in ('dir /B ') do (
set /a count+=1
echo !count!^) %%f

set mainMethod[!count!]=%%f

)
set /a maxCount=%count%





:mainMethod
If not exist %method% (
    mkdir %method%
) 
set /p yourMethod=請選擇要匯入的資料夾到%method%的資料夾:
for /f "delims=1,2,3,4,5,6,7,8,9,10" %%a in ("%yourMethod%") do if not "%%a"=="" echo 無效請重選 &goto mainMethod
if %yourMethod% gtr %maxCount% (
	echo 無效請重選
	call :mainMethod
	)
if %yourMethod% equ 0 (
	echo 無效請重選
	call :mainMethod
)

call echo 匯入 %%mainMethod[%yourMethod%]%% ...
call set ArrVar=%%mainMethod[%yourMethod%]%%
copy  %ArrVar% %method%
cd %method%
::刪除檔名帶有空格的空格
set "str= "
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")
echo.


:amountMainMethod
::計算檔案數量
set /a count=1
set /a methodOrder
for /f "tokens=*" %%i in ('dir /s^|find "File(s)" ') do ( set amount=%%i)
for /f %%f in ("%amount%") do (set methodAmount=%%f)
echo 數量為%methodAmount%
::更改黨名
for /f %%i in ('dir /b') do ( 
set methodOrder[!count!]=%%i
ren %%i !count!.csv  2>nul 
set /a count+=1
)
echo 匯入完成

cd ..	
echo.

::-------------------------------------------------------------------------------
::-- 
::-------------------------------------------------------------------------------

:displayFile
set /a count=1
for /f  %%f in ('dir /B ') do (
echo !count!^) %%f
set chebychev[!count!]=%%f
set /a count+=1
)
echo.

:cheby
If not exist "chebychev" (
    mkdir chebychev
) 
set /p yourChebychev=請選擇要匯入的資料夾到 chebychev的資料夾:
for /f "delims=0,1,2,3,4,5,6,7,8,9" %%a in ("%yourChebychev%") do if not "%%a"=="" echo 無效請重選 &goto cheby
if %yourChebychev% gtr %maxCount% (
	echo 無效請重選
	call :cheby
	)
if %yourChebychev% equ 0 (
	echo 無效請重選
	call :cheby
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
set /a count=1
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

::-------------------------------------------------------------------------------
::-- 
::-------------------------------------------------------------------------------

:displayFile
set /a count=1
for /f  %%f in ('dir /B ') do (
echo !count!^) %%f
set initialize[!count!]=%%f
set /a count+=1
)
echo.

:init
set /a count=1
If not exist "initialize" (
    mkdir initialize
) 
set /p yourInitialize=請選擇要匯入的資料夾到 initialize的資料夾:
for /f "delims=0,1,2,3,4,5,6,7,8,9" %%a in ("%yourInitialize%") do if not "%%a"=="" echo 無效請重選 &goto init
if %yourInitialize% gtr %maxCount% (
	echo 無效請重選
	call :init
	)
if %yourInitialize% equ 0 (
	echo 無效請重選
	call :init
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
set /a count=1
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

::-------------------------------------------------------------------------------
::-- 
::-------------------------------------------------------------------------------

:callmergepy
if %chebychevAmount% == %methodAmount% if %methodAmount% == %initializeAmount% (
mkdir outcome 2> NUL
echo.
echo 合併的檔案順序
echo Arima:
for /l %%f in (1,1,%chebychevAmount%) do ( call echo %%methodOrder[%%f]%% )
echo.
echo Chebychev:
for /l %%f in (1,1,%chebychevAmount%) do ( call echo %%chebychevOrder[%%f]%% )
echo.
echo Initialize:
for /l %%f in (1,1,%chebychevAmount%) do ( call echo %%initializeOrder[%%f]%% )
echo.
) else (
 echo oops, has problem 
 )

cd python
python home.py %chebychevAmount% 
cd ..
echo 確定刪除資料?
del /q initialize
del /q chebychev
del  /q %method%
del /q outcome





pause
