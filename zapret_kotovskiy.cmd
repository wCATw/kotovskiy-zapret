@echo off
net session >nul 2>&1
if %errorLevel% neq 0 (
    "%~dp0elevator" cmd /c "%~f0"
    exit /b
)

setlocal

:: Define arguments
set ARGS=--wf-tcp=80,443 --wf-udp=443,50000-65000 ^
--filter-tcp=80 --hostlist-auto="%~dp0files\list-auto.txt" --hostlist-auto-retrans-threshold=2 --hostlist-auto-debug="%~dp0files\auto.log" --hostlist-auto-fail-time=120 --methodeol --dpi-desync=fake,multisplit --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-repeats=6 --new ^
--filter-tcp=443 --hostlist-auto="%~dp0files\list-auto.txt" --hostlist-auto-retrans-threshold=2 --hostlist-auto-debug="%~dp0files\auto.log" --hostlist-auto-fail-time=120 --methodeol --dpi-desync=fake,multidisorder --dpi-desync-split-pos=1,midsld --dpi-desync-fooling=badseq,md5sig --dpi-desync-fake-tls-mod=rnd,dupsid,sni=www.google.com --dpi-desync-repeats=6 --new ^
--filter-udp=443 --hostlist-auto="%~dp0files\list-auto.txt" --hostlist-auto-retrans-threshold=2 --hostlist-auto-debug="%~dp0files\auto.log" --hostlist-auto-fail-time=120 --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%~dp0files\quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-65000 --hostlist-auto="%~dp0files\list-auto.txt" --hostlist-auto-retrans-threshold=2 --hostlist-auto-debug="%~dp0files\auto.log" --hostlist-auto-fail-time=120 --dpi-desync=fake --dpi-desync-fooling=badseq,md5sig --dpi-desync-repeats=6 --dpi-desync-any-protocol=1 --dpi-desync-cutoff=n2



netsh interface tcp set global timestamps=enabled
net stop zapret_kotovskiy >nul 2>&1
sc delete zapret_kotovskiy >nul 2>&1

:: Prompt using CHOICE
echo Install service?
choice /c YN /n /m "(Y/N): "

if errorlevel 2 goto RUN_DIRECT
if errorlevel 1 goto INSTALL_SERVICE

:INSTALL_SERVICE
sc create zapret_kotovskiy binPath= "\"%~dp0winws.exe\" %ARGS%" DisplayName= "zapret: kotovskiy" start= auto
sc start zapret_kotovskiy
echo Service installed and started.
pause
exit /b

:RUN_DIRECT
start "zapret: kotovskiy" "%~dp0winws.exe" %ARGS%
exit /b
