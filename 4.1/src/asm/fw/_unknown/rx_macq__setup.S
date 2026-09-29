/* rx_macq__setup @ 0x8d6390, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__init, rx_macq__setup_default, wmi_handler_cfg_rx_chain
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, get_g_8003bc, parse_ese, rx_chain__configure_b, rx_macq__program_ba_win, rx_queue__setup_ring
 */
	.section .text.rx_macq__setup,"ax",@progbits
	.global rx_macq__setup
rx_macq__setup:
	.global L_8d6390
L_8d6390:
	push_s blink
L_8d6392:
	bl L_8c02c0
L_8d6396:
	mov_s r13,r0
L_8d6398:
	mov_s r0,r2
L_8d639a:
	mov_s r15,r3
L_8d639c:
	mov_s r2,r4
L_8d639e:
	mov_s r3,r5
L_8d63a0:
	mov r4,r6
L_8d63a4:
	mov_s r14,r7
L_8d63a6:
	stb_s r1,[r13]
L_8d63a8:
	stb_s r0,[r13,0x1]
L_8d63aa:
	stw_s r14,[r13,0x2]
L_8d63ac:
	mov_s r1,0x0
L_8d63ae:
	ld_s r0,[sp,0x10]
L_8d63b0:
	stb_s r1,[r13,0x4]
L_8d63b2:
	st_s r0,[r13,0x8]
L_8d63b4:
	st_s r1,[r13,0xc]
L_8d63b6:
	mov_s r0,r13
L_8d63b8:
	mov_s r1,r15
L_8d63ba:
	bl.d L_8ded90
L_8d63be:
	mov_s r5,r14
L_8d63c0:
	bl L_8ca198
L_8d63c4:
	ldb_s r1,[r13,0x1]
L_8d63c6:
	cmp_s r1,0x0
L_8d63c8:
	cmp.ne r1,0x5
L_8d63cc:
	cmp.ne r1,0x1
L_8d63d0:
	bne_s L_8d63d4
L_8d63d2:
	mov_s r0,0x0
	.global L_8d63d4
L_8d63d4:
	cmp_s r1,0x3
L_8d63d6:
	mov r4,0x1
L_8d63da:
	mov.ne r4,r0
L_8d63de:
	mov_s r0,r13
L_8d63e0:
	mov_s r1,r15
L_8d63e2:
	mov_s r2,0x0
L_8d63e4:
	bl.d L_8db7fc
L_8d63e8:
	mov_s r3,r2
L_8d63ea:
	bl.d L_8db3cc
L_8d63ee:
	mov_s r0,r13
L_8d63f0:
	mov_s r0,r13
L_8d63f2:
	bl.d L_8c3b94
L_8d63f6:
	mov_s r1,r14
L_8d63f8:
	b L_8c032c
