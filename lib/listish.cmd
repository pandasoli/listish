setlocal EnableDelayedExpansion & :: [options, list, out]
	set options=%1
	set list=%2
	set out=%3

	call lib\list_size %list%, list_size
	if !list_size! == 0 exit /b 0

	call lib\get_cursor_pos pos_x, pos_y
	echo|set /p "=%ESC%[?25l"

	:: args
	set width=50
	set height=3
	set pos_x=2
	set pos_y=3
	set up_ch=w
	set down_ch=s
	set sel_ch=d

	set sel_cl=41;30
	set sel_align=center
	set "sel_left=-> "
	set "sel_right= <-"

	set unsel_cl=42;30
	set unsel_align=right
	set "unsel_left=--- "
	set "unsel_right= ---"

	set sel=1
	set scroll=0

	:process-args
	for /f "tokens=1,* delims= " %%a in (%options%) do (
		for /f "tokens=1,2 delims==" %%a in ("%%a") do set %%a=%%b
		set options="%%b"
		goto process-args
	)

	:: process items
	call lib\str_len "%sel_left%", sel_left_len
	call lib\str_len "%sel_right%", sel_right_len
	call lib\str_len "%unsel_left%", unsel_left_len
	call lib\str_len "%unsel_right%", unsel_right_len

	set item_y=0
	set box_width=

	(
		set /a sel_width=%width% - !sel_left_len! - !sel_right_len!
		set /a unsel_width=%width% - !unsel_left_len! - !unsel_right_len!

		if !sel_width! gtr !unsel_width! (
			set box_width=!sel_width!
		) else set box_width=!unsel_width!
	)

	for /l %%i in (1 1 !list_size!) do (
		call lib\list_i %list%, %%i, item
		call lib\str_len "!item!", len

		set /a parts=!len! / !box_width! + 1
		set list-%%i-size=!parts!
		set list-%%i-y=!item_y!
		set /a item_y+=!parts!

		rem height cannot fit an item
		if !parts! gtr %height% exit /b 0

		set /a part_size=!len! / !parts!

		for /l %%j in (1 1 !parts!) do (
			set /a index=%%j - 1
			set /a index=!index! * !part_size!

			rem make runtime variables (!) be called with %
			for /f "tokens=1,2" %%a in ("!index! !part_size!") do (
				set list-%%i-parts-%%j=!item:~%%a,%%b!
			)
		)
	)

	:: display
	:loop
	set /a view_bottom=!scroll! + %height%
	set /a display_y=%pos_y%

	for /l %%i in (1 1 !list_size!) do (
		set true=
		set top=!list-%%i-y!
		set /a bottom=!list-%%i-y! + !list-%%i-size!

		if !top! geq !scroll! if !top! lss !view_bottom! set true=1
		if !bottom! gtr !scroll! if !bottom! lss !view_bottom! set true=1

		if defined true (
			call lib\set_cursor_pos %pos_x%, !display_y!

			set align=%unsel_align%
			set cl=%unsel_cl%
			set "left=%unsel_left%"
			set "right=%unsel_right%"
			set left_len=%unsel_left_len%
			set right_len=%unsel_right_len%

			if !sel! == %%i (
				set align=%sel_align%
				set cl=%sel_cl%
				set "left=%sel_left%"
				set "right=%sel_right%"
				set left_len=%sel_left_len%
				set right_len=%sel_right_len%
			)

			for /l %%j in (1 1 !list-%%i-size!) do (
				set /a pos=!list-%%i-y! + %%j

				if !pos! gtr !scroll! if !pos! leq !view_bottom! (
					set part=!list-%%i-parts-%%j!
					set /a inside_width=%width% - !left_len! - !right_len!
					set /a display_y+=1

					if %%j == 1 (
						call lib\str_align "!part!", !align!, !inside_width!, text
						set text=!left!!text!!right!
					) else if %%i == !sel! (
						call lib\str_align "!part!", !align!, %width%, text
					) else (
						call lib\str_align "!part!", !align!, !inside_width!, text
						call lib\ch_repeat " ", !left_len!, left_space
						call lib\ch_repeat " ", !right_len!, right_space
						set text=!left_space!!text!!right_space!
					)

					echo %ESC%[!cl!m!text!%ESC%[m
				)
			)
		)
	)

	:: choose
	set "choice_list=%sel_ch%"

	if !sel! gtr 1 set "choice_list=!choice_list!%up_ch%"
	if !sel! lss !list_size! set "choice_list=!choice_list!%down_ch%"

	>nul choice /n /c !choice_list!
	set /a e=%errorlevel% - 1
	set ch=!choice_list:~%e%,1!

	call lib\str_contains %up_ch%, !ch!, isup
	call lib\str_contains %down_ch%, !ch!, isdown

	rem I'm too tired to think about a more
	rem universal way of resetting the scroll
	if !isup! == yes (
		set /a sel-=1

		for %%a in (!sel!) do (
			if !list-%%a-y! lss !scroll! set /a scroll=!list-%%a-y!
		)

		goto loop
	) else if !isdown! == yes (
		set /a sel+=1

		for %%a in (!sel!) do (
			set /a item_bottom=!list-%%a-y! + !list-%%a-size!
			set /a view_bottom=!scroll! + %height%

			if !item_bottom! gtr !view_bottom! set /a scroll+=!list-%%a-size!
		)

		goto loop
	)

(
	endlocal
	echo|set /p "=%ESC%[?25h"

	if "%out%" neq "" (
		call lib\list_i %list%, %sel%, %out%
	)
	exit /b %sel%
)
