	;; Miganie dioda z sekudnowym czekaniem jako subrutyna

.include "m32def.inc"

	ldi R16, HIGH(RAMEND) 				;inicjalizacja stosu
	out sph, R16
	ldi R16, LOW(RAMEND)
	out spl, R16
	ldi R16 0xFF
	out DDRA, R16									;konfiguracja wyjść
	clr R16
loop:
	out PORTA, R16								;wyświetlanie LED
	inc R16												;podbicie wartości
	push R16											;zabezpieczenie 
	call wait
	pop R16
	rjmp loop

	
wait:
	ldi R18, 0x7									;przygotowanie wartości 
second_init:	
	ldi R17, 0xFF
third_init:	
	ldi R16, 0xFF	
third_loop:
	dec R16												;trzecia petla (0-0xFF)
	brne third_loop
	dec R17												;druga petla (0-0xFF)
	brne third_init
	dec R18												;pierwsza petla (0-0xF)
	brne second_init
	ret 
