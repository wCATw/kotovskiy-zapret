@echo off
net session >nul 2>&1
if %errorLevel% neq 0 (
    "%~dp0elevator" cmd /c "%~f0"
    exit /b
)

set ARGS=--wf-tcp=80,443 --wf-udp=443,50000-65535 ^
--filter-tcp=80 --hostlist=\"%~dp0files\list.txt\" --hostlist-auto=\"%~dp0files\list-auto.txt\" --dpi-desync=fake,fakedsplit --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist=\"%~dp0files\list.txt\" --hostlist-auto=\"%~dp0files\list-auto.txt\" --dpi-desync=fake,multidisorder --dpi-desync-split-pos=1,midsld --dpi-desync-repeats=11 --dpi-desync-fooling=badseq,md5sig --dpi-desync-fake-tls-mod=rnd,dupsid,sni=www.google.com --new ^
--filter-udp=443 --hostlist=\"%~dp0files\list.txt\" --hostlist-auto=\"%~dp0files\list-auto.txt\" --dpi-desync=fake --dpi-desync-repeats=11 --dpi-desync-fake-quic=\"%~dp0files\quic_initial_www_google_com.bin\" --new ^
--filter-udp=50000-65535 --filter-l7=discord,stun --dpi-desync-fooling=badseq,md5sig --dpi-desync=fake --new ^
--filter-udp=443 --dpi-desync=fake --dpi-desync-repeats=11
net stop zapret_kotovskiy
sc delete zapret_kotovskiy
sc create zapret_kotovskiy binPath= "\"%~dp0winws.exe\" %ARGS%" DisplayName= "zapret: kotovskiy" start= auto
sc start zapret_kotovskiy
pause