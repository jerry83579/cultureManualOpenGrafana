@setlocal enableextensions enabledelayedexpansion
echo off
chcp 65001
cls
MODE con: COLS=60 
set /a date=%date:~3,6%+1 
:: DDDDDDDDDDDDDDDD
set /a year=6
rem 年份大小
set month=12
rem 判斷年份超過9補0
set monthsize=9

rem 顯示選擇資料庫圖表/提供使用者選擇資料庫圖表
:dashboard
echo.
python dashboardSelection.py 

set /a count=0
FOR /F %%i IN (data.txt) DO (
  set urlUid[!count!]=%%i%
  set /a count+=1
)
set uid=%urlUid[0]%
set url=%urlUid[1]%
set title=%urlUid[2]%


python dashboardStop.py %uid%
if %errorlevel% equ 1 (
call :dashboard
echo.
)
echo.


rem 提供選擇年分
:start
echo.
for /l %%x in (1, 1, !year!) do (
set /a sum=!date! - %%x
set number=%%x^)
echo !number! !sum!
echo.
)


:cho1
set /p fromYear=  選擇年分: 
for /f "delims=123456789" %%a in ("%fromYear%") do if not "%%a"=="" echo 無效請重選 &goto cho1
	if %fromYear% gtr %year% (
	 echo 無效請重選
	 call :cho1
	)
	

set /a yourFromYear=%date%-%fromYear%
echo %yourFromYear%
	 

echo.	

	
for /l %%x in (1, 1, !month!) do (
   echo %%x^) %%x
   echo.
)


:cho2
set /p fromMonth=  選擇月份:
for /f "delims=0123456789" %%a in ("%fromMonth%") do if not "%%a"=="" echo 無效請重選 &goto cho2
	if %fromMonth% gtr %month% (
	 echo 無效請重選
	 call :cho2
	)
	if %fromMonth% equ 0 (
	echo 無效請重選
	 call :cho2
	)

set /a yourFromMonth=%fromMonth%
echo %yourFromMonth%


if %yourFromMonth% gtr %monthsize% (
    set year1=!yourFromYear!-!yourFromMonth!-01T00:00:00.000Z
	echo =================
	echo 你選擇 %yourFromYear%-%yourFromMonth%-01T00:00:00.000Z
	echo =================
	echo.
	set a=test.txt
    echo,%yourFromYear%-%yourFromMonth%-01T00:00:00.000Z> "!a!"
	
) else (
    set year1=!yourFromYear!-0!yourFromMonth!-01T00:00:00.000Z
	echo =================
	echo 你選擇 %yourFromYear%-0%yourFromMonth%-01T00:00:00.000Z
	echo =================
	echo.
	set a=test.txt
    echo,%yourFromYear%-0%yourFromMonth%-01T00:00:00.000Z> "!a!"
)


for /l %%x in (1, 1, !year!) do (
set /a sum=!date! - %%x
set number=%%x^)
echo !number! !sum!
echo.
)


:cho3
set /p toYear=  選擇年分: 
for /f "delims=123456789" %%a in ("%toYear%") do if not "%%a"=="" echo 無效請重選 &goto cho3
	if %toYear% gtr %year% (
	 echo 無效請重選
	 call :cho3
	)
	

set /a yourToYear=%date%-%toYear%
echo %yourToYear%
echo.   
   

 
for /l %%x in (1, 1, !month!) do (
   echo %%x^) %%x
   echo.
)

echo.	

:cho4
set /p toMonth=  選擇月份:
for /f "delims=123456789" %%a in ("%toMonth%") do if not "%%a"=="" echo 無效請重選 &goto cho4
	if %toMonth% gtr %month% (
	 echo 無效請重選
	 call :cho4
	)
	if %toMonth% equ 0 (
	echo 無效請重選
	 call :cho4
	)

set /a yourToMonth=%toMonth%
echo %yourToMonth%
)

if %yourToMonth% gtr %monthsize% (
    set year2=!yourToYear!-!yourToMonth!-01T00:00:00.000Z
	echo =================
	echo 你選擇 %yourToYear%-%yourToMonth%-01T00:00:00.000Z
	echo =================
	echo.
	set a=test.txt
    echo,%yourToYear%-%yourToMonth%-01T00:00:00.000Z>> "!a!"
	
) else (
    set year2=!yourToYear!-0!yourToMonth!-01T00:00:00.000Z
	echo =================
	echo 你選擇 %yourToYear%-0%yourToMonth%-01T00:00:00.000Z
	echo =================
	echo.
	set a=test.txt
    echo,%yourToYear%-0%yourToMonth%-01T00:00:00.000Z>> "!a!"
)

SET /P areyousure=時間範圍: %year1% to %year2%(Y/[N])?
IF '%areyousure%'=='Y' GOTO theEnd
IF '%areyousure%'=='y' GOTO theEnd
IF '%areyousure%'=='N' GOTO reStart
IF '%areyousure%'=='n' GOTO reStart

:reStart
echo Please select again
echo.
goto start
EXIT

:theEnd
python dateSelection.py %uid%
del data.txt
del test.txt
start http://10.20.1.231:3000/d/%uid%/%title%?orgId=1


pause


