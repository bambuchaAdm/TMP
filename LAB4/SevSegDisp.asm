	;; Wyświetlanie kolejnych liczb pierwszych

.CSEG
	ldi spl, low(RAMEND)
	ldi sph, high(RAMEND)
	
	ldi zl, low(2*primes)
	ldi zh, high(2*primes)
	ldi yl, low(2*hexs)
	ldi yh, high(2*hexs)

	ldi R22, 0xFE
	ldi R23, 0xFD
	ldi R24, 0xF7

loop:
	lpm r19, Z+
	lpm r20, Z+
	lpm r21, Y+

	out PORTA, r19
	out PORTA, r20

	call wait

	rjmp loop

.ORG 0x100
.CSEG
pirmes:
	.DB 0x7E 0x6D 0x7E 0x79 0x7E 0x5B 0x7E 0x70 0x30 0x30 0x30 0x79 0x30 0x70 0x30 0x7B 0x6D 0x79 0x6D 0x7B 0x79 0x30
hexs:
	.DB 0x7E 0x30	0x6D 0x79 0x33 0x5B 0x5F 0x70 0x7F 0x7B 0x77 0x1F 0x4E 0x3D 0x4F 0x47
	
.CSEG
;;; Procedra czekania sekundę
wait:
	ldi R18, 0x7									;przygotowanie wartości 
first_loop:	
	ldi R17, 0xFF
second_loop:	
	ldi R16, 0xFF	
third_loop:
	dec R16												;trzecia petla (0-0xFF)
	brne third_loop
	sbic R17, 0
	rjmp second_segment
	out PORTB, R22
	out PORTA, R19
	rjmp second_cond
second_segment:
	sbic R17, 1
	jrmp last_segment
	out PORTB, R23
	out PORTA, R20
	jrmp sceond_cond
last_segment:	
	out PORTB, R24,
	out PORTA, R21
second_cond:	
	dec R17												;druga petla (0-0xFF)
	brne third_init
	dec R18												;pierwsza petla (0-0xF)
	brne second_init
	ret 

