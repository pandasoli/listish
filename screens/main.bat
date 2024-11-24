setlocal EnableDelayedExpansion

(
	cls

	set items="Eli Soli hfdkaj flkadj flkaj fdlkjadfafhawioh falk fh oqwhofs fahlahfdiewofh alsfh iowho" Bolsonaro Gustavo Finn John Andrea Luiz Micheli
	call lib\listish "height=5 pos_x=3 up_ch=wk down_ch=sj unsel_left= unsel_right= sel_cl=1 unsel_cl=90", items, out

	echo !errorlevel! "!out!"
)
