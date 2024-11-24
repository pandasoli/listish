setlocal & :: [x, y]
	echo|set/p "=%ESC%[%2;%1H"

(
	endlocal
	exit /b 0
)
