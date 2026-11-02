@echo off
echo Starting CineSense AI React Frontend on http://localhost:3000 ...
set "PATH=C:\Program Files\nodejs;%PATH%"
cd frontend
call "C:\Program Files\nodejs\npm.cmd" run dev
pause

