# genosine
Console-wrapper for Sinus Creator by The Gang that generates 8-bit sin/cos tables. To be used standalone in custom build systems, for example [c64-devkit](https://github.com/cliffordcarnmo/c64-devkit).

## Building
`gcc genosine.c -o genosine -lm`

## Usage
`genosine <amount> <min> <max> <startAngle> <stopAngle> <amplitude> <frequency> <mode>`

## Example usage
`genosine 256 0 100 0 360 100 0 0`

The `mode` argument works with `0 = sin` and `1 = cos`.

## Example output
~~~
!byte $3f,$41,$42,$44,$45,$47,$48,$4a
!byte $4b,$4d,$4e,$50,$52,$53,$54,$56
!byte $57,$59,$5a,$5c,$5d,$5e,$60,$61
!byte $62,$64,$65,$66,$67,$69,$6a,$6b
!byte $6c,$6d,$6e,$6f,$70,$71,$72,$73
!byte $74,$75,$76,$76,$77,$78,$79,$79
!byte $7a,$7a,$7b,$7b,$7c,$7c,$7d,$7d
!byte $7d,$7e,$7e,$7e,$7e,$7e,$7e,$7e
!byte $7e,$7e,$7e,$7e,$7e,$7e,$7e,$7d
!byte $7d,$7d,$7c,$7c,$7c,$7b,$7b,$7a
!byte $79,$79,$78,$77,$77,$76,$75,$74
!byte $73,$73,$72,$71,$70,$6f,$6e,$6d
!byte $6b,$6a,$69,$68,$67,$66,$64,$63
!byte $62,$60,$5f,$5e,$5c,$5b,$5a,$58
!byte $57,$55,$54,$52,$51,$4f,$4e,$4c
!byte $4b,$49,$48,$46,$44,$43,$41,$40
!byte $3e,$3d,$3b,$3a,$38,$36,$35,$33
!byte $32,$30,$2f,$2d,$2c,$2a,$29,$27
!byte $26,$24,$23,$22,$20,$1f,$1e,$1c
!byte $1b,$1a,$18,$17,$16,$15,$14,$13
!byte $11,$10,$0f,$0e,$0d,$0c,$0b,$0b
!byte $0a,$09,$08,$07,$07,$06,$05,$05
!byte $04,$03,$03,$02,$02,$02,$01,$01
!byte $01,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$01
!byte $01,$01,$02,$02,$03,$03,$04,$04
!byte $05,$05,$06,$07,$08,$08,$09,$0a
!byte $0b,$0c,$0d,$0e,$0f,$10,$11,$12
!byte $13,$14,$15,$17,$18,$19,$1a,$1c
!byte $1d,$1e,$20,$21,$22,$24,$25,$27
!byte $28,$2a,$2b,$2c,$2e,$30,$31,$33
!byte $34,$36,$37,$39,$3a,$3c,$3d,$3f
~~~
