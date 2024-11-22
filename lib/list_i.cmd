setlocal EnableDelayedExpansion & : [list, index, out]
	set i=1
	set res=

	for %%a in (!%1!) do (
		if !i! == %2 (
			set res=%%~a
			goto end
		)

		set /a i+=1
	)
	:end

	if !i! lss %2 (
		: list smaller than index
		exit /b 1
	)
(
	endlocal
	set %3=%res%
	exit /b 0
)