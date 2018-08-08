	screen = $0400
	screenScroller = $0400+40*24
	code = $0801
	bitmap = $2000
	charset = $3800
	sprites = $3e00
	bitmapColors = $4000
	tables = $5000
	music = $7000
	musicPlay = $7003
	bitmapScreen = $8000
	colors = $d800

	line1 = 0
	line2 = 114

	*= bitmap
	!binary "data/logo-bitmap.dat",2544

	*= charset
	!binary "data/charset.dat",800
	
	*= sprites
	!binary "data/sprites.dat"

	*= bitmapColors
	!binary "data/logo-colors.dat"

	*= bitmapScreen
	!binary "data/logo-screen.dat"

	*= tables
sinTable1:
	!source "data/sin1.dat"

sinTable2:
	!source "data/sin2.dat"
	!source "data/sin2.dat"

sinTable3:
	!source "data/sin3.dat"

sinTable4:
	!source "data/sin4.dat"

colorTable:
	!byte $06,$06,$0e,$03,$0d,$07,$0f,$01
	!byte $01,$0f,$07,$0d,$03,$0e,$06,$06

colorTable2:
	!byte $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	!byte $0b,$0b,$0c,$0c,$0c,$0c,$0c,$0f
	!byte $0f,$03,$03,$07,$01,$01,$01,$01
	!byte $01,$07,$03,$03,$0c,$0c,$0b,$0b
	!byte $0b,$0b,$0b,$0b

infoText:
	!scr "S github.com/cliffordcarnmo/c64-devkit S"

	*= music
	!binary "data/86400_7k.sid",,$7e

	*= code
	jsr $e544
	jsr initSprites

	lda #%00011110
	sta $d018

	sei

	lda #$7f
	sta $dc0d
	sta $dd0d

	lda $dc0d
	lda $dd0d

	lda #$01
	sta $d01a

	lda #$1b
	sta $d011

	lda #$35
	sta $01

	lda #line1
	sta $d012

	lda #<irq1
	sta $fffe
	lda #>irq1
	sta $ffff

	jsr	music
	jsr	timerSetup

	lda #$00
	sta $d020
	sta $d021

	ldx #$00
writeText:
	lda infoText,x
	sta screen+40*24,x
	lda #$01
	sta colors+40*24,x
	inx
	cpx #40
	bne writeText

	ldx #$00
l:
	lda bitmapColors,x
	sta colors,x

	lda bitmapScreen,x
	sta $0400,x

	inx
	cpx #$ff
	bne l

	ldx #$00
l2:
	lda bitmapColors+$ff,x
	sta colors+$ff,x

	lda bitmapScreen+$ff,x
	sta screen+$ff,x

	inx
	cpx #$40
	bne l2

	lda #$02
	sta $d800+40*24
	sta $d827+40*24

	cli

mainloop:
	jsr	plasma
	jmp mainloop

irq1:
	pha
	txa
	pha
	tya
	pha

	lda #$ff
	sta $d019
	
	jsr graphicsMode
	jsr musicPlay
	jsr moveSprites
	jsr colorCycle

	inc $90
	inc $92

	lda #line2
	sta $d012

	lda #<irq2
	sta $fffe
	lda #>irq2
	sta $ffff

	pla
	tay
	pla
	tax
	pla

	rti

irq2:
	pha
	txa
	pha
	tya
	pha

	lda #$ff
	sta $d019
	
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	jsr textMode

	lda #line1
	sta $d012

	lda #<irq1
	sta $fffe
	lda #>irq1
	sta $ffff

	pla
	tay
	pla
	tax
	pla

	rti

plasma:
	ldy $64

	!for i, 8, 23 {
		ldx $90
		lda sinTable2+i,x
		adc $64
		tax

		lda sinTable1+i,x
		sta screen+40*i,y
		tax

		lda colorTable-64,x
		ora $dc09
		and #$07
		sta colors+40*i,y
	}

	inc $64

	lda $64
	cmp #40
	beq zero64
	rts

zero64:
	lda #$00
	sta $64
	rts

initSprites:
	lda #$f8
	sta $07f8
	lda #$f9
	sta $07f9
	lda #$fa
	sta $07fa
	lda #$fb
	sta $07fb
	lda #$fc
	sta $07fc
	lda #$fd
	sta $07fd
	lda #$fe
	sta $07fe
	lda #$ff
	sta $07ff

	lda #$01
	sta $d025
	lda #$06
	sta $d026
	lda #$02
	sta $d027
	sta $d028
	sta $d029
	sta $d02a
	sta $d02b
	sta $d02c
	sta $d02d
	sta $d02e

	lda	#%11111111
	sta $d015
	
	lda #%00000000
	sta $d01b

	lda #%11111111
	sta $d01c

	lda #%11000000
	sta $d01d
	sta $d017
	
	lda #%00000000
	sta $d010

	rts

moveSprites:
	ldx $92

	lda sinTable4,x
	sta $d000
	lda sinTable3,x
	sta $d001

	inx
	inx
	inx
	inx
	inx
	inx
	inx
	inx

	lda sinTable4,x
	sta $d002
	lda sinTable3,x
	sta $d003

	inx
	inx
	inx
	inx
	inx
	inx
	inx
	inx

	lda sinTable4,x
	sta $d004
	lda sinTable3,x
	sta $d005

	inx
	inx
	inx
	inx
	inx
	inx
	inx
	inx

	lda sinTable4,x
	sta $d006
	lda sinTable3,x
	sta $d007

	inx
	inx
	inx
	inx
	inx
	inx
	inx
	inx

	lda sinTable4,x
	sta $d008
	lda sinTable3,x
	sta $d009

	inx
	inx
	inx
	inx
	inx
	inx
	inx
	inx

	lda sinTable4,x
	sta $d00a
	lda sinTable3,x
	sta $d00b

	lda #155
	sta $d00c
	lda #155
	sta $d00d

	lda #190
	sta $d00e
	lda #155
	sta $d00f

	rts

colorCycle:
	lda colorTable2
	sta colorTable2+36
	
	ldx #$00

cl:
	lda colorTable2+1,x
	sta colorTable2,x
	sta $dbc2,x

	inx
	cpx #36
	bne cl
	rts

timerSetup:
	lda	#$00
	sta	$dc0e
	sta	$dc0f
	sta	$dc0b
	sta	$dc0a
	sta	$dc09
	sta	$dc08
	rts

textMode:
	lda #%11001000
	sta $d016

	lda #%00011011
	sta $d011
	rts

graphicsMode:
	lda #%11011000
	sta $d016

	lda #%00111011
	sta $d011
	rts

