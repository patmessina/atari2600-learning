	processor 6502

	include "include/vcs.h"
	include "include/macro.h"
	
	seg code
	org $F000  			; define the code origin at $F000

main:
	CLEAN_START			; Macro to safely clear the memory

; start a new frame by turning on vsync and vblank
nextFrame:
	lda #2 					; same as %00000010
	sta VBLANK      ; enable vblank
	sta VSYNC      	; enable vsync

	; generate the three lines of vsync
	sta WSYNC 			; first scanline
	sta WSYNC 			; second scanline
	sta WSYNC 			; third scanline

	lda #0
	sta VSYNC 			; turn off vsync

	; let the tia output the recommended 37 scanlines of vblank
	ldx #37
loopVBlank:
	sta WSYNC
	dex
	bne loopVBlank

	lda #0
	sta VBLANK		; turn off vblank

	; draw 192 visible scanlines (kernel)
	ldx #192				; counter for 192 scanlines
; loopScanline:
loopVisible:
	stx COLUBK			; set background color
	sta WSYNC				
	dex
	bne loopVisible

	; output 30 more vblank lines
	lda #2
	sta VBLANK
	
	ldx #30

loopOverscan:
	sta WSYNC
	dex
	bne loopOverscan

	jmp nextFrame

; FILL the ROM size to exactly 4KB
	org $FFFC   		
	.word main			; Rest vector at $FFFC (where the program starts)
	.word main     ; interrupt vector at $FFFE (unused in the VCS, but required by atari)
