;;; Odejmowanie dwóch liczb


	ldi R16, 0xFF
	out DDRA, R16
	out DDRB, R16
	out DDRC, R16

	;; R10 - aktywny wyświetlacz
	ldi R10, 0b10001000

	.EQU val1=453, val2=333

	;; (R9, R8) - val1
	lid R9, HIGH(val1)
	lid R8, LOW(val1)
	
	;; (R7, R6) - val2
	lid R7, HIGH(val2)
	lid R6, LOW(val2)

	;; (R9, R8) - (R7, R6)

	sub R8, R6
	sbc R9, R7

	call show_overflow

loop:
	
	mov R0, R8
	call show_register
	mov R0, R9
	call show_register
	rjmp loop

;; R0 - liczba do wyswietlenia
show_register:
	call split
	call show_digit
	call next_display
	mov R0, R1
	call show_digit
	call next_display
	ret

	;; R0 - libcza do podzielenia
	;; R0 - dolne 4 bity
	;; R1 - gorne 4 bity
split:
	mov R16, R0
	andi R16, 0xF0
	swap R16
	mov R1, R16
	mov R16, R0
	andi R16, 0x0F
	mov R0, R16
	ret

digits:
	.DB 0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B, 0x77, 0x1F, 0x4E, 0x3D, 0x4F, 0x47
	;; bierze liczbe do wyswietlenia w R0
show_digit:
	ldi ZL, LOW(2*digits)
	ldi ZH, HIGH(2*digits)
	add ZL, R0
	lpm R0, Z
	com R0
	out PORTA, R0
	ret

;;; array[1] -> *(array+1)

;;; 0 1 2 3 4 5 6 7 8 9 A B C D E F

	;; aktywuje nastpeny wyswietlacz
next_dispaly:
	sbrc R10, 0
	sec	
 	ror R10
	mov R0, R10
	com R0
	out PORTB, R0
	ret
	
	;; wartosc bezwzględna względem R0
abs:
	tst R0
	brpl abs_end
	com R0
	inc R0
abs_end:	
	ret

show_overflow:
	brvc show_overflow_end
	ldi R16, 0x1
	out PORTC, R16
show_overflow_end:	
	ret
