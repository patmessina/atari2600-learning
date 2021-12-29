	processor 6502

	include "include/vcs.h"
	include "include/macro.h"
	
	seg code
	org $F000  			; define the code origin at $F000

main:
	CLEAN_START			; Macro to safely clear the memory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Set background luminosity color to yellow
; view colors: https://en.wikipedia.org/wiki/List_of_video_game_console_palettes#NTSC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	lda #$1E 			; Load color into A ($1E in MTSC yellow)
	sta COLUBK   ; store A to background color address $09

	jmp main


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FILL the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	org $FFFC   		
	.word main			; Rest vector at $FFFC (where the program starts)
	.word main     ; interrupt vector at $FFFE (unused in the VCS, but required by atari)
