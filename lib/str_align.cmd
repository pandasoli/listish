setlocal & : [str, align, width, out]
	call lib\str_len "%~1", len

	set str=%~1
	set align=%2
	set /a missing=%3 - !len!

	if "%align%" == "left" (
		for /l %%# in (1 1 !missing!) do set "str=!str! "
	) else if "%align%" == "right" (
		for /l %%# in (1 1 !missing!) do set "str= !str!"
	) else if "%align:~0,6%" == "center" (
		set /a size=!missing! / 2
		set /a odd=!missing! %% 2

		for /l %%# in (1 1 !size!) do set "str= !str!"
		for /l %%# in (1 1 !size!) do set "str=!str! "

		if !odd! == 1 (
			if "%align%" == "center-right" (
				set "str= !str!"
			) else (
				set "str=!str! "
			)
		)
	)

(
	endlocal
	set %4=%str%
	exit /b 0
)