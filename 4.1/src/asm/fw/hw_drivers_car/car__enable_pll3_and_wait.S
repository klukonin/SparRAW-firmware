/* car__enable_pll3_and_wait @ 0x8cd478, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hw_drivers_car.c
 * Зовут его: hwd__wait_pll_lock, ut_hw_drivers_cmd_0x201
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_sysassert_fatal, get_reg88afec_s3_w32
 */
	.section .text.car__enable_pll3_and_wait,"ax",@progbits
	.global car__enable_pll3_and_wait
car__enable_pll3_and_wait:
	.global L_8cd478
L_8cd478:
	push_s blink
L_8cd47a:
	bl L_8c02bc
L_8cd47e:
	mov_s r13,0x880c00
L_8cd484:
	ld_s r1,[r13,0x60]
L_8cd486:
	bset_s r1,r1,0x3
L_8cd488:
	st_s r1,[r13,0x60]
L_8cd48a:
	mov_s r1,0x880a80
L_8cd490:
	ld_s r2,[r1,0x3c]
L_8cd492:
	breq r0,0x0,L_8cd530
L_8cd496:
	bbit1 r2,0x1,L_8cd4ec
L_8cd49a:
	ld_s r0,[r1,0x3c]
L_8cd49c:
	bset_s r0,r0,0x1
L_8cd49e:
	st_s r0,[r1,0x3c]
L_8cd4a0:
	mov r0,0x3e8
	.global L_8cd4a4
L_8cd4a4:
	ld_s r15,[r13,0x60]
L_8cd4a6:
	bl.d L_8cd27c
L_8cd4aa:
	mov_s r16,r0
L_8cd4ac:
	mov_s r14,r0
L_8cd4ae:
	btst_s r15,0x3
L_8cd4b0:
	cmp.eq r14,0x1
L_8cd4b4:
	bne_s L_8cd4be
L_8cd4b6:
	sub r0,r16,0x1
L_8cd4ba:
	brhs r0,0x1,L_8cd4a4
	.global L_8cd4be
L_8cd4be:
	btst_s r15,0x3
L_8cd4c0:
	cmp.eq r14,0x1
L_8cd4c4:
	bne_s L_8cd4e8
L_8cd4c6:
	mov_s r2,0x1019edc
L_8cd4cc:
	mov_s r0,0x0
L_8cd4ce:
	bl.d L_8edfb0
L_8cd4d2:
	mov_s r1,r0
L_8cd4d4:
	mov_s r0,blink
L_8cd4d6:
	mov_s r2,0x1019efc
L_8cd4dc:
	mov_s r1,0x132b
L_8cd4e2:
	bl.d L_8c82c0
L_8cd4e6:
	mov_s r3,0x5a
	.global L_8cd4e8
L_8cd4e8:
	brne r14,0x1,L_8cd4f6
	.global L_8cd4ec
L_8cd4ec:
	ld_s r0,[r13,0x60]
L_8cd4ee:
	bset_s r0,r0,0x3
L_8cd4f0:
	st_s r0,[r13,0x60]
L_8cd4f2:
	b L_8c0324
	.global L_8cd4f6
L_8cd4f6:
	mov_s r0,blink
L_8cd4f8:
	mov_s r2,0x1019efc
L_8cd4fe:
	mov_s r1,0x1418
L_8cd504:
	mov_s r3,0x5b
L_8cd506:
	b_s L_8cd52a
	.global L_8cd508
L_8cd508:
	bbit1 r0,0x3,L_8cd4ec
L_8cd50c:
	mov_s r2,0x1019edc
L_8cd512:
	mov_s r0,0x0
L_8cd514:
	bl.d L_8edfb0
L_8cd518:
	mov_s r1,r0
L_8cd51a:
	mov_s r0,blink
L_8cd51c:
	mov_s r2,0x1019efc
L_8cd522:
	mov_s r1,0x132c
L_8cd528:
	mov_s r3,0x6d
	.global L_8cd52a
L_8cd52a:
	bl L_8c82c0
L_8cd52e:
	b_s L_8cd4ec
	.global L_8cd530
L_8cd530:
	bbit0 r2,0x1,L_8cd4ec
L_8cd534:
	ld_s r0,[r1,0x3c]
L_8cd536:
	mov lp_count,0x3e8
L_8cd53a:
	bclr_s r0,r0,0x1
L_8cd53c:
	st_s r0,[r1,0x3c]
L_8cd53e:
	lp L_8cd54a
L_8cd542:
	ld_s r0,[r13,0x60]
L_8cd544:
	btst_s r0,0x3
L_8cd546:
	bne_s L_8cd508
L_8cd548:
	nop_s
	.global L_8cd54a
L_8cd54a:
	b_s L_8cd508
