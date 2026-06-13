PurifyEffect_:
	ldh a, [hWhoseTurn]
	and a
	; Load Player's Turn data
	ld de, wEnemyMonStatus
	ld hl, wBattleMonMaxHP
	ld bc, wBattleMonHP
	jr z, .PurifyEffect
	; If it's not Player's turn, load relevant Enemy stats instead.
	ld de, wBattleMonStatus
	ld hl, wEnemyMonMaxHP
	ld bc, wEnemyMonHP
.PurifyEffect
	ld a, [de]
	and a ; does the target have a status ailment?
	jr nz, .itSucceeded
	; Target must have a status condition.
	ld c, 50
	call DelayFrames
	jpfar PrintDidntAffectText
.itSucceeded
	; Clear the target's status condition
	xor a
	ld [de], a

	; Heal the user

	; de = Max HP
	ld a, [hli]
	ld d, a
	ld a, [hld]
	ld e, a

	push bc

	; bc = Current HP
	ld h, b ; hl = CurrentHP ptr
	ld l, c
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a

	; hl = Max HP - Current HP
	ld a, e
	sub c
	ld l, a
	ld a, d
	sbc b
	ld h, a

	push de

	; de = Maximum amount to heal = 1/2 Max HP
	srl d
	rr e

	; Cap amount to heal at amount missing
	ld a, l
	sub e
	ld a, h
	sbc d
	jr nc, .updateHP
	ld d, h
	ld e, l
.updateHP
	; Prep CurrentHP for HP Bar
	ld a, c ; CurrentHpLow
	ld [wHPBarOldHP], a
	ld a, b ; CurrentHpHigh
	ld [wHPBarOldHP+1], a
	; Now prep MaxHP
	pop hl
	ld a, l ; MaxHpLow
	ld [wHPBarMaxHP], a
	ld a, h ; MaxHpHigh
	ld [wHPBarMaxHP+1], a
	; Add ToHeal to HP.
	ld a, c
	add e
	ld c, a
	ld a, b
	adc d
	ld b, a
	; Save CurrentHP (bc)
	pop hl ; ptr to CurrentHP
	ld a, b ; CurrentHpHigh
	ld [wHPBarNewHP+1], a
	ld [hli], a
	ld a, c ; CurrentHpLow
	ld [wHPBarNewHP], a
	ld [hl], a
	; HP bar rendering stuff
	hlcoord 10, 9
	ldh a, [hWhoseTurn]
	and a
	ld a, $1
	jr z, .updateHPBar
	hlcoord 2, 2
	xor a
.updateHPBar
	ld [wHPBarType], a
	predef UpdateHPBar2
	ld hl, EnemyStatusChangesEliminatedText
	jp PrintText

EnemyStatusChangesEliminatedText:
	text_far _EnemyStatusChangesEliminatedText
	text_end