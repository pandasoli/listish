:: Microsoft Windows CMD.exe Version 10.0.22631.3880 ::

@echo off

set window-width=60
set window-height=30
set "window-size=%window-width%,%window-height%"

title "Console Games Menu"
mode %window-size%
color 0f

: used at lib\cecho
for /f %%A in ('echo prompt $E^| cmd') do set ESC=%%A

screens\main