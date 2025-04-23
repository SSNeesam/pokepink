LoadYellowTitleScreenGFX:
	ld hl, PokemonLogoGraphics
	ld de, vChars2
	ld bc, PokemonLogoGraphicsEnd - PokemonLogoGraphics
	ld a, BANK(PokemonLogoGraphics)
	call FarCopyData
	ld hl, PokemonLogoCornerGraphics
	ld de, vChars1 tile $7d
	ld bc, PokemonLogoCornerGraphicsEnd - PokemonLogoCornerGraphics
	ld a, BANK(PokemonLogoCornerGraphics)
	call FarCopyData
	ld hl, TitlePikachuBGGraphics
	ld de, vChars1
	ld bc, TitlePikachuBGGraphicsEnd - TitlePikachuBGGraphics
	ld a, BANK(TitlePikachuBGGraphics)
	call FarCopyData
	ld hl, TitlePikachuOBGraphics
	ld de, vChars1 tile $70
	ld bc, TitlePikachuOBGraphicsEnd - TitlePikachuOBGraphics
	ld a, BANK(TitlePikachuOBGraphics)
	call FarCopyData
	ret

TitleScreen_PlacePokemonLogo:
	hlcoord 2, 1
	ld de, TitleScreenPokemonLogoTilemap
	lb bc, 7, 16
	call Bank3D_CopyBox
	ret

TitleScreen_PlacePikaSpeechBubble:
	hlcoord 6, 4
	ld de, TitleScreenPikaBubbleTilemap
	lb bc, 4, 7
	call Bank3D_CopyBox
	hlcoord 9, 8
	ld [hl], $64
	inc hl
	ld [hl], $65
	ret

TitleScreen_PlacePikachu:
	hlcoord 4, 8
	ld de, TitleScreenPikachuTilemap
	lb bc, 9, 12
	call Bank3D_CopyBox
	hlcoord 16, 10
	ld [hl], $00
	hlcoord 16, 11
	ld [hl], $00
	hlcoord 16, 12
	ld [hl], $00
	hlcoord 16, 13
	ld [hl], $00
	ld de, wShadowOAM
	ld bc, $20
	call CopyData
	ret

Bank3D_CopyBox:
; copy cxb (xy) screen area from de to hl
.row
	push bc
	push hl
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

TitleScreenPokemonLogoTilemap: ; 16x7
	INCBIN "gfx/title/pokemon_logo.tilemap"

Pointer_f4669: ; unreferenced
	db $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $5f

TitleScreenPikaBubbleTilemap: ; 7x4
	INCBIN "gfx/title/pika_bubble.tilemap"

TitleScreenPikachuTilemap: ; 12x9
	INCBIN "gfx/title/pikachu.tilemap"
	;db $00, $80, $81, $00, $00, $00, $00, $00, $82, $83, $84, $00
	;db $00, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $00
	;db $00, $00, $8f, $90, $91, $92, $93, $94, $95, $96, $97, $00
	;db $00, $00, $00, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $00
	;db $00, $00, $00, $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7, $00
	;db $00, $00, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $a6, $af, $00
	;db $00, $00, $b0, $b1, $b2, $b3, $b4, $b5, $b6, $b7, $b8, $00
	;db $00, $00, $b9, $ba, $bb, $bc, $bd, $be, $bf, $00, $00, $00

PokemonLogoGraphics: INCBIN "gfx/title/pokemon_logo.2bpp"
PokemonLogoGraphicsEnd:
PokemonLogoCornerGraphics: INCBIN "gfx/title/pokemon_logo_corner.2bpp"
PokemonLogoCornerGraphicsEnd:
TitlePikachuBGGraphics: INCBIN "gfx/title/pikachu_bg.2bpp"
TitlePikachuBGGraphicsEnd:
TitlePikachuOBGraphics: INCBIN "gfx/title/pikachu_ob.2bpp"
TitlePikachuOBGraphicsEnd:
