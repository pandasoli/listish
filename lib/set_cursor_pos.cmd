setlocal & : [x, y]
	echo %ESC%[%2;%1H

(
	endlocal
	exit /b 0
)