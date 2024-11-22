setlocal EnableDelayedExpansion

(
	cls

	set items="Eli Soli" Bolsonaro Gustavo Finn John Andrea Luiz Micheli
	call lib\listish "up_ch=wk down_ch=sj sel_cl=1 unsel_cl=90", items, out

	echo !errorlevel! "!out!"
)