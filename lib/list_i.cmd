setlocal EnableDelayedExpansion & :: [list, index, out]
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

	:: list smaller than index
	if !i! lss %2 exit /b 1
(
	endlocal
	set %3=%res%
	exit /b 0
)
