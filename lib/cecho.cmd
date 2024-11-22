setlocal EnableDelayedExpansion & : [text]
	set text=%*
	set text=!text:{=%ESC%[!
	set text=!text:}=m!

	echo !text!
(
	endlocal
	exit /b 0
)