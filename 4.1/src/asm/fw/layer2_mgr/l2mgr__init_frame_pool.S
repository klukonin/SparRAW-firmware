/* l2mgr__init_frame_pool @ 0x8ed578, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_l2mgr__init_frame_pool
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mem_pool__init, memset0_words
 */
	.section .text.l2mgr__init_frame_pool,"ax",@progbits
	.global l2mgr__init_frame_pool
l2mgr__init_frame_pool:
	.global L_8ed578
L_8ed578:
	push_s blink
L_8ed57a:
	bl.d L_8c02c4
L_8ed57e:
	mov_s r1,0x4b
L_8ed580:
	mov_s r14,0x844914
L_8ed586:
	mov_s r0,r14
L_8ed588:
	/* bl.d 0x008c1a78 */
	.byte 0xf2,0x0c,0x2f,0xea
L_8ed58c:
	/* _asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8ed58e:
	mov_s r13,0x8034a8
L_8ed594:
	add r0,r13,0x2c
L_8ed598:
	mov_s r1,r14
L_8ed59a:
	mov_s r2,0x28
L_8ed59c:
	bl.d L_8c6c70
L_8ed5a0:
	mov_s r3,0x78
L_8ed5a2:
	add3 r0,r13,0x8
L_8ed5a6:
	st_s r0,[r13,0x4]
L_8ed5a8:
	add2 r0,r13,0x15
L_8ed5ac:
	st_s r0,[r13]
L_8ed5ae:
	mov_s r0,0x2
L_8ed5b0:
	b.d L_8c0334
L_8ed5b4:
	stb r0,[gp, 0xd5]
