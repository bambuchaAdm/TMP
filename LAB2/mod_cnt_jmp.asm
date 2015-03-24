	;; Inkrementowanie wartości wyświetlanej przez diody LED
	;; R1 wartość
	;; R15 pierwszy licznik
	;; R16 drugi licznik
	;; R17 trzeci licznik
	;; f = 1MHz, 1 instrukcja 1 takt
	;; 1e6 taktow na 1s = 1e6 ~= 0xFF * 0xFF * 0xF - last part will be used

	clr R1

loop:

	inc R1
	out PORTA, R1

wait:
	ldi R18, 0xF									; Ustawienie trzeciego licznika
	ldi R17, 0xFF									; Ustawienie drugiego licznika
	ldi R16, 0xFF 								; Ustawienie pierwszego licznika
	
trzecia:	
	dec R16												; zmniejszamy licznik pierwszej petli
	breq druga										; jeżeli nie jest równy zero wracamy na początek trzeciej pętli
	rjmp trzecia:

druga:	
	dec R17												; zmniejszamy licznik drugiej petli
	breq pierwsza  									; jeżeli nie jest równy zero wracamy na początek drugiej pętli
	jmp init_druga

pierwsza:	
	dec R18												; zmieniejszamy licznik ostatniej petli
	breq loop											; jeżeli nie jest równy zero wracamy na początek pierwszej pętli
	jmp init_pierwsza


init_pierwsza:
	ldi R17, 0xFF
init_druga:
	ldi R16, 0xFF
	jmp trzecia
