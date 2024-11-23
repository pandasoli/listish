setlocal & :: [list, out]
	set size=0

	for %%# in (!%1!) do set /a size+=1

(
	endlocal
	set %2=%size%
	exit /b 0
)
