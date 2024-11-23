setlocal & :: [str, char, out]
	set str=%~1
	set res=no

	for %%i in ("%~2") do (
		if "!str:%%~i=!" neq "!str!" (
			set res=yes
			goto end
		)
	)
	:end

(
	endlocal
	set %3=%res%
	exit /b 0
)
