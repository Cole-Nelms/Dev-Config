@echo on

:: This is a Windows shell script
:: for setting up my development
:: tools on Windows without
:: admin, or installing software
:: on the system.

:: You can just ignore this script
:: as it is intended for a very
:: specific circumstance.

set LOCALPROGRAMS=%LOCALAPPDATA%\Programs
set CMAKE=%LOCALPROGRAMS%\cmake\bin

set PATH=%CMAKE%;%LOCALPROGRAMS%;%PATH%
start %LOCALPROGRAMS%\alacritty.exe --command %LOCALPROGRAMS%\git\bin\bash.exe
