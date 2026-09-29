/* mac__publish_masks @ 0x9373b0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__enable_qset_bit7, mid_vring_mask_update, rf_sector__clear_sta_bit, set_reg_886f00_928d78, uc_res_vote__acquire, uc_res_vote__release
 */
	.section .text.mac__publish_masks,"ax",@progbits
	.global mac__publish_masks
mac__publish_masks:
	.global L_9373b0
L_9373b0:
	mov_s r2,0x800400
L_9373b6:
	ld_s r0,[r2,0x14]
L_9373b8:
	mov_s r1,0x800a28
L_9373be:
	st_s r0,[r1]
L_9373c0:
	ld_s r0,[r2,0x1c]
L_9373c2:
	st_s r0,[r1,0x4]
L_9373c4:
	ld_s r0,[r2,0x24]
L_9373c6:
	st_s r0,[r1,0x8]
L_9373c8:
	mov_s r2,0x4
L_9373ca:
	b_s L_9373da
	.global L_9373cc
L_9373cc:
	mov_s r0,0x0
	.global L_9373ce
L_9373ce:
	mov_s r1,0x886d8c
L_9373d4:
	add2_s r1,r1,r2
L_9373d6:
	st_s r0,[r1]
L_9373d8:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_9373da
L_9373da:
	brge r2,0x8,L_937400
L_9373de:
	mov_s r1,0x0
L_9373e0:
	ld_s r0,[gp,-0x74]
L_9373e2:
	bset r1,r1,r2
L_9373e6:
	and_s r0,r0,r1
L_9373e8:
	cmp_s r0,0x0
L_9373ea:
	mov_s r0,0x1
L_9373ec:
	sub_s.ne r0,r0,r0
L_9373ee:
	extb.f 0x0,r0
L_9373f2:
	bne_s L_9373cc
L_9373f4:
	mov_s r0,0x800a18
L_9373fa:
	ld.as r0,[r0,r2]
L_9373fe:
	b_s L_9373ce
	.global L_937400
L_937400:
	j_s [blink]
L_937402:
	nop_s
