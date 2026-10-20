/* mac__publish_masks @ 0x93d0ac, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__pause_sta_tx, bf__resume_sta_tx, internal_tx__drop_event_mask_and_publish, internal_tx__set_pending_flag, uc_res_vote__acquire, uc_res_vote__release
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__publish_masks
mac__publish_masks:
	.global L_93d0ac
L_93d0ac:
	mov_s r2,0x800400
L_93d0b2:
	ld_s r0,[r2,0x14]
L_93d0b4:
	mov_s r1,0x80157c
L_93d0ba:
	st_s r0,[r1]
L_93d0bc:
	ld_s r0,[r2,0x1c]
L_93d0be:
	st_s r0,[r1,0x4]
L_93d0c0:
	ld_s r0,[r2,0x24]
L_93d0c2:
	st_s r0,[r1,0x8]
L_93d0c4:
	mov_s r2,0x4
L_93d0c6:
	b_s L_93d0d6
	.global L_93d0c8
L_93d0c8:
	mov_s r0,0x0
	.global L_93d0ca
L_93d0ca:
	mov_s r1,0x886d8c
L_93d0d0:
	add2_s r1,r1,r2
L_93d0d2:
	st_s r0,[r1]
L_93d0d4:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_93d0d6
L_93d0d6:
	brge r2,0x8,L_93d0fc
L_93d0da:
	mov_s r1,0x0
L_93d0dc:
	ld_s r0,[gp,-0x7c]
L_93d0de:
	bset r1,r1,r2
L_93d0e2:
	and_s r0,r0,r1
L_93d0e4:
	cmp_s r0,0x0
L_93d0e6:
	mov_s r0,0x1
L_93d0e8:
	sub_s.ne r0,r0,r0
L_93d0ea:
	extb.f 0x0,r0
L_93d0ee:
	bne_s L_93d0c8
L_93d0f0:
	mov_s r0,0x80156c
L_93d0f6:
	ld.as r0,[r0,r2]
L_93d0fa:
	b_s L_93d0ca
	.global L_93d0fc
L_93d0fc:
	j_s [blink]
L_93d0fe:
	nop_s
