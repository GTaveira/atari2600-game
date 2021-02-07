
	processor 6502
	include vcs.h
	org $F000
Start
	sei
	cld
	ldx #$FF
	txs
	lda #0
ClearMem
	sta 0,X
	dex
	bne ClearMem
	
	lda #44
	sta COLUBK
	lda #33
	sta COLUP0
	lda #06
	sta COLUPF
MainLoop
	lda  #2
	sta  VSYNC
	sta  WSYNC
	sta  WSYNC
	sta  WSYNC
	lda  #43      ; This is where we are wasting time (2798 cycles available here) 2798/64 = 43
	sta  TIM64T   ; TODO: replace these two lines with game logic
	lda #0
	sta  VSYNC

WaitForVblankEnd
	lda INTIM
	bne WaitForVblankEnd
	ldy #191

	sta WSYNC
	sta VBLANK
	lda #$50
	sta HMM0

	sta WSYNC
	sta HMOVE
	
ScanLoop
	sta WSYNC
	lda #2
	sta ENAM0
	dey
	
	sty COLUBK
	
	bne ScanLoop

	lda #2
	sta WSYNC
	sta VBLANK
	ldx #30
OverScanWait
	sta WSYNC
	dex
	bne OverScanWait
	jmp  MainLoop
	
ltrblk  .word  letterg    ;where all the sprites are at
        .word  lettert
	
letterg .byte %11100111	
        .byte %10100101	
        .byte %10100101	
        .byte %11100111	
        .byte %10100101	
        .byte %10100101	
        .byte %11100111
		
lettert .byte %11100111	
        .byte %10100101	
        .byte %10100101	
        .byte %11100111	
        .byte %10100101	
        .byte %10100101	
        .byte %11100111	
	
	org $FFFC
	.word Start
	.word Start