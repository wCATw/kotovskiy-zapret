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

"%~dp0elevator" %0 del
goto :eof

:end
pause
