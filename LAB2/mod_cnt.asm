	;; Inkrementowanie wartości wyświetlanej przez diody LED
	;; R1 wartość
	;; R16 pierwszy licznik
	;; R17 drugi licznik
	;; R18 trzeci licznik
	;; f = 1MHz, 1 instrukcja 1 takt
	;; 1e6 taktow na 1s = 1e6 ~= 0xFF * 0xFF * 0xF - last part will be used

	.include "m32def.inc"

	clr R1

loop:

	inc R1
	out PORTA, R1

wait:
	ldi R18, 0xF									; Ustawienie trzeciego licznika
pierwsza:	
	ldi R17, 0xFF									; Ustawienie drugiego licznika
druga:	
	ldi R16, 0xFF 								; Ustawienie pierwszego licznika
trzecia:	
	dec R16												; zmniejszamy licznik pierwszej petli
	brne trzecia									; jeżeli nie jest równy zero wracamy na początek trzeciej pętli
	
	dec R17												; zmniejszamy licznik drugiej petli
	brne druga  									; jeżeli nie jest równy zero wracamy na początek drugiej pętli

	dec R18												; zmieniejszamy licznik ostatniej petli
	brne pierwsza									; jeżeli nie jest równy zero wracamy na początek pierwszej pętli

	rjmp loop


