@echo off
title Wii U Auto Brew
color 0f

:menu
cls
echo Wii U Auto Brew
echo 1) Start Homebrew
echo 2) Move Homebrew to SD Card
echo 3) Requirements
echo 4) Open HELP
echo 5) Exit
choice /c:12345 >nul
if %errorlevel% == 1 goto start
if %errorlevel% == 2 goto movehb
if %errorlevel% == 3 goto req
if %errorlevel% == 4 goto help
if %errorlevel% == 5 exit

:movehb
if not exist SD/wiiu goto moveerror
cls
powershell gdr -PSProvider 'FileSystem'
echo ---------
echo Type the drive letter the SD card
echo (It's the one with a lot less storage)
set /p dlr=
if not exist %dlr%: goto sderror
if %dlr% == c goto winerror
if %dlr% == C goto winerror
xcopy "SD" "%dlr%:/" /s/h/e/k/f/c
rmdir SD /S /Q
md SD
cls
echo Moved contents to SD card. You are ready to homebrew.
pause>nul 
goto menu

:winerror
cls
echo The C Drive has Windows on it.
echo Please choose your SD Card next time.
pause>nul
goto menu

:sderror
cls
echo No SD Card found on %dlr%.
pause>nul
goto menu

:moveerror 
cls
echo Please run "Start Homebrew" before using this option.
pause>nul
goto menu

:req
cls
echo Requirements
echo ------------
echo You must meet the following requirements to use this tool.
echo 1. Empty 16+ GB SD Card (Formatted to FAT 32 and 64KB allocation size)
echo 2. Wii U is running version 5.5.2
echo 3. If you are using Haxchi CFW you need a compatible VC DS game
echo 4. If you are using Mocha CFW your Wii U Browser save data is reset
echo 5. You have read the HELP.txt file
pause>nul
goto menu

:help
cls
type HELP.txt
pause>nul
goto menu

:start
cls
echo Have you read the requirements?
echo 1) Yes
echo 2) No
choice /c:12 >nul
if %errorlevel% == 2 goto req
cls
echo Have you read HELP file?
echo 1) Yes
echo 2) No
choice /c:12 >nul
if %errorlevel% == 2 goto help
cls
echo Which method do you want to use?
echo 1) Haxchi
echo 2) Mocha CFW
echo 3) Install Both
echo 4) Cancel
choice /c:1234 >nul
if %errorlevel% == 1 goto haxchi
if %errorlevel% == 2 goto mochacfw
if %errorlevel% == 3 goto allinone
if %errorlevel% == 4 goto menu

:allinone
cd SD
md wiiu
md install
md cbhc
md haxchi 
cd wiiu
md apps
cd ..
cd ..
cd hbfiles
xcopy "i" "../SD/install/" /s/h/e/k/f/c
xcopy "a" "../SD/wiiu/apps/" /s/h/e/k/f/c
cd ..
xcopy "hbfiles/haxchi" "SD/haxchi/" /s/h/e/k/f/c
xcopy "hbfiles/cbhc" "SD/cbhc/" /s/h/e/k/f/c
cls
echo Finished homebrew and installed both methods.
echo You can only use one method on the Wii U.
echo Press 2 on the menu screen.
pause>nul
goto menu

:haxchi
cd SD
md wiiu
md install
md cbhc
md haxchi 
cd wiiu
md apps
cd ..
cd ..
cd hbfiles
xcopy "i" "../SD/install/" /s/h/e/k/f/c
xcopy "a" "../SD/wiiu/apps/" /s/h/e/k/f/c
cd ..
rmdir /S /Q SD\wiiu\apps\mocha
xcopy "hbfiles/haxchi" "SD/haxchi/" /s/h/e/k/f/c
xcopy "hbfiles/cbhc" "SD/cbhc/" /s/h/e/k/f/c
cls
echo Finished homebrew using Haxchi!
echo Press 2 on the menu screen.
pause>nul
goto menu

:mochacfw
cd SD
md wiiu
md install
cd wiiu
md apps
cd ..
cd ..
cd hbfiles
xcopy "i" "../SD/install/" /s/h/e/k/f/c
xcopy "a" "../SD/wiiu/apps/" /s/h/e/k/f/c
cd ..
rmdir /S /Q SD\wiiu\apps\haxchi
rmdir /S /Q SD\wiiu\apps\cbhc
cls
echo Finished homebrew using Mocha CFW!
echo Press 2 on the menu screen.
pause>nul
goto menu

