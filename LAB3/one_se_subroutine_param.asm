	;; Miganie dioda z sekudnowym czekaniem jako subrutyna
	;; Parametr 

.CSEG
.ORG 0x0
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
	sts delay, 1
	call wait
	pop R16
	rjmp loop

.DSEG
.ORG RAMBEGIN
delay: .BYTE 1
	
.CSEG	
wait:
	lds R3, delay
	ldi R18, 0x3d									;przygotowanie wartości 
	mul R3, R18										;MUL Rd, Rs => R0, R1 <- Rd * Rs   mnozymy stala razy parametr
	mov R18, R0										;wynik jest warunkiem pierwszej petli
second_init:	
	ldi R17, 0xFF 								;
third_init:	
	ldi R16, 0xFF	
third_loop:
	dec R16												;trzecia petla (0-0xFF)
	brne third_loop
	dec R17												;druga petla (0-0xFF)
	brne third_init								;jeżeli to rzechodzi mamy za sobą ((255*2)+4)*255 + 2 = 131072 instrukcji
	dec R18												;pierwsza petla (0-0x7)
	brne second_init
	ret
