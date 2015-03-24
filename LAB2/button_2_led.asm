	;; Pojedyncze przelaczanie

	.include "m32def.inc"
	
	.EQU S1=0
	.EQU LED=4

loop:	
	sbic PINB, S1
	sbi PORTA, LED
	sbis PINB, S1
	cli PORTA, LED
	rjmp loop
