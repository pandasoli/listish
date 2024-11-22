setlocal & : [list, out]
	set size=0

	for %%# in (!%1!) do set /a size+=1

(
	endlocal

	if "%2" neq "" (
		set %2=%size%
		exit /b 0
	) else (
		exit /b %size%
	)
)