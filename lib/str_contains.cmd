setlocal & : [str, char, out]
	set str=%~1
	set res=no

	: I had to take the verification if out of the `if defined str`
	: because it was giving non-sense syntax errors when str gets
	: empty and it shouldn't even process what's inside the if.

	goto loop
	:process

	if "%str:~0,1%" == "%~2" (
		set res=yes
		goto end
	)

	set str=%str:~1%

	:loop
	if defined str goto process

	:end

(
	endlocal
	set %3=%res%
	exit /b 0
)