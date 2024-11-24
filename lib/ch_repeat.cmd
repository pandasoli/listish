setlocal & :: [ch, times, out]
	set ch=%~1
	set res=

	for /l %%# in (1 1 %2) do set res=!res!%ch%
(
	endlocal
	set %3=%res%
	exit /b 0
)
