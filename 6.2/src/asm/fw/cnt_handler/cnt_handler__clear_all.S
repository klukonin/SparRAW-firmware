/* cnt_handler__clear_all @ 0x8f6424, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main, mlme_sm__disconnect_ev_handle
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 * Глобалы (через gp): 0x8003d8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global cnt_handler__clear_all
cnt_handler__clear_all:
	.global L_8f6424
L_8f6424:
	push_s blink
L_8f6426:
	push_s r13
L_8f6428:
	mov r2,0x3e8
L_8f642c:
	mov_s r1,0x7b
L_8f642e:
	mov_s r13,0x887000
L_8f6434:
	st 0x3d8000,[r13, 0x8]
L_8f643c:
	mov lp_count,0x3e9
L_8f6440:
	asl_s r1,r1,0xf
L_8f6442:
	lp L_8f6454
L_8f6446:
	ld_s r0,[r13,0x8]
L_8f6448:
	bbit0 r0,0x1e,L_8f6452
L_8f644c:
	ld_s r0,[r13,0x8]
L_8f644e:
	bbit1 r0,0x1f,L_8f6454
	.global L_8f6452
L_8f6452:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
	.global L_8f6454
L_8f6454:
	brne_s r2,0,L_8f647c
L_8f6456:
	ld_s r0,[gp,0x254]
L_8f6458:
	mov lp_count,0x3e9
L_8f645c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f645e:
	st.as r0,[gp,0x95]
L_8f6462:
	mov r0,0x3e8
L_8f6466:
	st_s r1,[r13,0x8]
L_8f6468:
	lp L_8f647a
L_8f646c:
	ld_s r1,[r13,0x8]
L_8f646e:
	bbit0 r1,0x1e,L_8f6478
L_8f6472:
	ld_s r1,[r13,0x8]
L_8f6474:
	bbit1 r1,0x1f,L_8f647a
	.global L_8f6478
L_8f6478:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
	.global L_8f647a
L_8f647a:
	breq_s r0,0,L_8f64c8
	.global L_8f647c
L_8f647c:
	st 0x2a4000,[r13, 0x8]
L_8f6484:
	mov lp_count,0x2711
L_8f648c:
	mov_s r1,0x2710
L_8f6492:
	lp L_8f649e
L_8f6496:
	ld_s r0,[r13,0x8]
L_8f6498:
	bbit1 r0,0x1f,L_8f649e
L_8f649c:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
	.global L_8f649e
L_8f649e:
	breq_s r1,0,L_8f64d6
	.global L_8f64a0
L_8f64a0:
	st 0x1a2000,[r13, 0x8]
L_8f64a8:
	mov lp_count,0x2711
L_8f64b0:
	mov_s r0,0x2710
L_8f64b6:
	lp L_8f64c2
L_8f64ba:
	ld_s r1,[r13,0x8]
L_8f64bc:
	bbit1 r1,0x1e,L_8f64c2
L_8f64c0:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
	.global L_8f64c2
L_8f64c2:
	breq_s r0,0,L_8f64e4
	.global L_8f64c4
L_8f64c4:
	b L_8c025c
	.global L_8f64c8
L_8f64c8:
	mov_s r0,blink
L_8f64ca:
	mov_s r1,0x1187
L_8f64d0:
	bl L_8c9b28
L_8f64d4:
	b_s L_8f647c
	.global L_8f64d6
L_8f64d6:
	mov_s r0,blink
L_8f64d8:
	mov_s r1,0x1188
L_8f64de:
	bl L_8c9b28
L_8f64e2:
	b_s L_8f64a0
	.global L_8f64e4
L_8f64e4:
	mov_s r0,blink
L_8f64e6:
	mov_s r1,0x1189
L_8f64ec:
	bl L_8c9b28
L_8f64f0:
	b_s L_8f64c4
L_8f64f2:
	nop_s
