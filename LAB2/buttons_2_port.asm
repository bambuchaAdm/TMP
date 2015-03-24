	;; Move from one program to another

	in r1, pinb									; take pin status to r1
	out r1, porta									; put pin status to leds

loop:	
	rjmp loop
