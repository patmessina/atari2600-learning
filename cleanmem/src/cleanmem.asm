	processor 6502
	
	seg code
	org $F000  			; define the code origin at $F000

Start:
	sei							; disable interrupts
	cld							; disable the bcd decimal math mode
	ldx #$FF        ; loads X register with #$FF
	txs             ; transfer the X register to the (s)tack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; clear the Page Zero region ($00 tto $FF)
; that is the entire RAM and also the entire TIA registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	lda #0 					; A = 0
	ldx #$FF				; X = #$FF
	sta $FF					; make sure $FF is zeroed before the loop starts

MemLoop:
	dex							; decrement X
	sta $0,x				; store the value of A inside memory address $0 + x
	bne MemLoop			; Loop unit X is equal to zero (z flag is set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FILL the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	org $FFFC   		
	.word Start			; Rest vector at $FFFC (where the program starts)
	.word Start     ; interrupt vector at $FFFE (unused in the VCS, but required by atari)
