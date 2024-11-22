setlocal & : [x out, y out]
	set x=
	set y=

	for /f "tokens=1,2" %%a in (
  	'powershell.exe -nop -ep Bypass -c "$pos=$host.UI.RawUI.CursorPosition;(''+($pos.X+1)+' '+($pos.Y+1))"'
	) do (
		set x=%%a
		set y=%%b
	)

(
	endlocal
	set %1=%x%
	set %2=%y%
	exit /b 0
)