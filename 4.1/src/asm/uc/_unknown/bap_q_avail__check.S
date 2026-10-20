/* bap_q_avail__check @ 0x92c4b8, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__check_status
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc
 */
	.section .text.bap_q_avail__check,"ax",@progbits
	.global bap_q_avail__check
bap_q_avail__check:
	.global L_92c4b8
L_92c4b8:
	push_s blink
L_92c4ba:
	bl.d L_920210
L_92c4be:
	mul64 r0,0x2c
L_92c4c2:
	mov_s r14,0x801738
L_92c4c8:
	mov_s r3,mlo
L_92c4ca:
	add_s r13,r14,r3
L_92c4cc:
	ldb_s r15,[r13,0x1e]
L_92c4ce:
	ldb_s r0,[r13,0x1b]
L_92c4d0:
	brne_s r15,0,L_92c4e4
L_92c4d2:
	add_s r14,r14,r0
L_92c4d4:
	ldb.a r0,[r3,r14]
L_92c4d8:
	add_s r0,r0,r1
L_92c4da:
	stb_s r0,[r3]
L_92c4dc:
	ldb_s r0,[r3,0xd]
L_92c4de:
	add_s r2,r2,r0
L_92c4e0:
	stb_s r2,[r3,0xd]
L_92c4e2:
	b_s L_92c522
	.global L_92c4e4
L_92c4e4:
	ld_s r0,[gp,-0x44]
L_92c4e6:
	and r0,r0,0xfffff0ff
L_92c4ee:
	bset r1,r0,0xa
L_92c4f2:
	bset_s r1,r1,0xb
L_92c4f4:
	or r0,r0,0x1d000c00
L_92c4fc:
	st.as r1,[gp,-0x11]
L_92c500:
	mov_s r32,r0
L_92c502:
	st.ab r0,[r25,0x4]
L_92c506:
	bclr r25,r25,0xa
L_92c50a:
	nop_s
L_92c50c:
	nop_s
L_92c50e:
	nop_s
L_92c510:
	asl.f 0x0,r41,0x2
L_92c514:
	bne_s L_92c51c
L_92c516:
	mov_s r0,0x0
L_92c518:
	stb_s r0,[r13,0x1e]
L_92c51a:
	b_s L_92c522
	.global L_92c51c
L_92c51c:
	ld_s r0,[r13,0x20]
L_92c51e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92c520:
	st_s r0,[r13,0x20]
	.global L_92c522
L_92c522:
	b L_92027c
L_92c526:
	nop_s
