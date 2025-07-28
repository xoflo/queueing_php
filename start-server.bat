@echo off
cd /d C:\xampp\htdocs\queueing_api
echo Starting server.js... > server-log.txt
node server.js >> server-log.txt 2>&1
pause