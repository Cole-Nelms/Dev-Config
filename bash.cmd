@echo on

set LOCALPROGRAMS=%LOCALAPPDATA%\Programs
set CMAKE=%LOCALPROGRAMS%\cmake\bin

set PATH=%CMAKE%;%LOCALPROGRAMS%;%PATH%
start %LOCALPROGRAMS%\alacritty.exe --command %LOCALPROGRAMS%\git\bin\bash.exe