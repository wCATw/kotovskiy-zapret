@echo off
set TERM=
cd /d "%~dp0bin" && "%~dp0..\..\elevator" .\bash --login -i
