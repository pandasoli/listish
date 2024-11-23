setlocal & :: [str, out]
	set "str=%~1"
	set len=0

	:loop
	if defined str (
		set "str=%str:~1%"
		set /a len+=1
		goto loop
	)

(
	endlocal
	set %2=%len%
	exit /b 0
)
