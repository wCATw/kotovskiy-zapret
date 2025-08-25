@echo off
if "%1%" == "del" (
	echo DELETE WINDIVERT DRIVER
	net stop zapret_kotovskiy
	sc stop zapret_kotovskiy
	sc delete zapret_kotovskiy
	net stop windivert
	sc stop windivert
	sc delete windivert
	goto :end
)

sc qc windivert
if errorlevel 1 goto :end

echo.
choice /C YN /M "Do you want to stop and delete kotovskiy's zapret?"
if ERRORLEVEL 2 goto :eof

"%~dp0elevator" %0 del
goto :eof

:end
pause
