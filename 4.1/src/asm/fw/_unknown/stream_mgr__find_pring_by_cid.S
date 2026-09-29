/* stream_mgr__find_pring_by_cid @ 0x8caae0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__data_port_open, l2mgr__vring_drained
 */
	.section .text.stream_mgr__find_pring_by_cid,"ax",@progbits
	.global stream_mgr__find_pring_by_cid
stream_mgr__find_pring_by_cid:
	.global L_8caae0
L_8caae0:
	mov_s r3,0x0
L_8caae2:
	b_s L_8caae6
	.global L_8caae4
L_8caae4:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8caae6
L_8caae6:
	brhs r3,0xa,L_8cab08
L_8caaea:
	mov_s r1,0x8485dc
L_8caaf0:
	sub3 r1,r1,0x100
L_8caaf4:
	add2_s r1,r1,r3
L_8caaf6:
	ld r1,[r1,0x818]
L_8caafe:
	breq_s r1,0,L_8caae4
L_8cab00:
	ld_s r2,[r1]
L_8cab02:
	brne r0,r2,L_8caae4
L_8cab06:
	b_s L_8cab0a
	.global L_8cab08
L_8cab08:
	mov_s r1,0x0
	.global L_8cab0a
L_8cab0a:
	j_s.d [blink]
L_8cab0c:
	mov_s r0,r1
L_8cab0e:
	nop_s
