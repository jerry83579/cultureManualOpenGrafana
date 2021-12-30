@setlocal enableextensions enabledelayedexpansion
echo off

cls
MODE con: COLS=60 

::�P�_method�Olstm�٬Oarima
cd python
for /f %%i in (mainConfig.py) do (
  if  "%%i"=="method='lstm'" ( set method=lstm)
  if  "%%i"=="method='arima'" ( set method=arima)
)
cd ..

::�e�{��Ƨ�
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
set /p yourMethod=�п�ܭn�פJ����Ƨ���%method%����Ƨ�:
for /f "delims=1,2,3,4,5,6,7,8,9,10" %%a in ("%yourMethod%") do if not "%%a"=="" echo �L�ĽЭ��� &goto mainMethod
if %yourMethod% gtr %maxCount% (
	echo �L�ĽЭ���
	call :mainMethod
	)
if %yourMethod% equ 0 (
	echo �L�ĽЭ���
	call :mainMethod
)

call echo �פJ %%mainMethod[%yourMethod%]%% ...
call set ArrVar=%%mainMethod[%yourMethod%]%%
copy  %ArrVar% %method%
cd %method%
::�R���ɦW�a���Ů檺�Ů�
set "str= "
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")
echo.


:amountMainMethod
::�p���ɮ׼ƶq
set /a count=1
set /a methodOrder
for /f "tokens=*" %%i in ('dir /s^|find "File(s)" ') do ( set amount=%%i)
for /f %%f in ("%amount%") do (set methodAmount=%%f)
echo �ƶq��%methodAmount%
::����ҦW
for /f %%i in ('dir /b') do ( 
set methodOrder[!count!]=%%i
ren %%i !count!.csv  2>nul 
set /a count+=1
)
echo �פJ����

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
set /p yourChebychev=�п�ܭn�פJ����Ƨ��� chebychev����Ƨ�:
for /f "delims=0,1,2,3,4,5,6,7,8,9" %%a in ("%yourChebychev%") do if not "%%a"=="" echo �L�ĽЭ��� &goto cheby
if %yourChebychev% gtr %maxCount% (
	echo �L�ĽЭ���
	call :cheby
	)
if %yourChebychev% equ 0 (
	echo �L�ĽЭ���
	call :cheby
)
	
call echo �פJ %%chebychev[%yourChebychev%]%% ...
call set copy=%%chebychev[%yourChebychev%]%%
copy  %copy% chebychev

cd chebychev
set "str= "
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")

dir /b

:amountRenameChebychev
::�p���ɮ׼ƶq
set /a count=1
set /a chebychevOrder
for /f "tokens=*" %%i in ('dir /s^|find "File(s)" ') do ( set amount=%%i)
for /f %%f in ("%amount%") do (set chebychevAmount=%%f)
echo �ƶq��%chebychevAmount%
::����ҦW
for /f %%i in ('dir /b') do ( 
set chebychevOrder[!count!]=%%i
ren %%i !count!.csv  2>nul 
set /a count+=1
)
echo �פJ����
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
set /p yourInitialize=�п�ܭn�פJ����Ƨ��� initialize����Ƨ�:
for /f "delims=0,1,2,3,4,5,6,7,8,9" %%a in ("%yourInitialize%") do if not "%%a"=="" echo �L�ĽЭ��� &goto init
if %yourInitialize% gtr %maxCount% (
	echo �L�ĽЭ���
	call :init
	)
if %yourInitialize% equ 0 (
	echo �L�ĽЭ���
	call :init
)
	
call echo �פJ %%initialize[%yourInitialize%]%% ...
call set copy=%%initialize[%yourInitialize%]%%
copy  %copy% initialize

cd initialize
set "str= "
for /f "delims=" %%i in ('dir /b *.*') do (
set "var=%%i" & ren "%%i" "!var:%str%=!")

dir /b

:amountRenameInitialize
::�p���ɮ׼ƶq
set /a count=1
set /a initializeOrder
for /f "tokens=*" %%i in ('dir /s^|find "File(s)" ') do ( set amount=%%i)
for /f %%f in ("%amount%") do (set initializeAmount=%%f)
echo �ƶq��%initializeAmount%
::����ҦW
for /f %%i in ('dir /b') do ( 
set initializeOrder[!count!]=%%i
ren %%i !count!.csv  2>nul 
set /a count+=1
)
echo �פJ����

cd ..
echo.

::-------------------------------------------------------------------------------
::-- 
::-------------------------------------------------------------------------------

:callmergepy
if %chebychevAmount% == %methodAmount% if %methodAmount% == %initializeAmount% (
mkdir outcome 2> NUL
echo.
echo �X�֪��ɮ׶���
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
del /q initialize
del /q chebychev
del  /q %method%
del /q outcome





pause
