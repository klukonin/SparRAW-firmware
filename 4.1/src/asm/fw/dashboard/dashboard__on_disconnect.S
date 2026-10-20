/* dashboard__on_disconnect @ 0x8e5820, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dashboard.cpp
 * Зовут его: l2mgr__disconnect_done
 * Зовёт сам: __ld_r13_ret, bf_w_s29_w3, fw_sysassert_fatal
 */
	.section .text.dashboard__on_disconnect,"ax",@progbits
	.global dashboard__on_disconnect
dashboard__on_disconnect:
	.global L_8e5820
L_8e5820:
	push_s blink
L_8e5822:
	push_s r13
L_8e5824:
	brge.d r0,0x8,L_8e5852
L_8e5828:
	mov_s r13,r0
	.global L_8e582a
L_8e582a:
	mov_s r2,0x854880
L_8e5830:
	ld_s r1,[r2,0x78]
L_8e5832:
	add3 r0,r2,0xf
L_8e5836:
	lsr_s r1,r1,0x1d
L_8e5838:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8e583a:
	bmsk_s r1,r1,0x2
L_8e583c:
	bl L_8e8498
L_8e5840:
	mov_s r1,0x854900
L_8e5846:
	ldb_s r0,[r1]
L_8e5848:
	bclr r0,r0,r13
L_8e584c:
	b.d L_8c033c
L_8e5850:
	stb_s r0,[r1]
	.global L_8e5852
L_8e5852:
	mov_s r0,blink
L_8e5854:
	mov_s r2,0x1014c54
L_8e585a:
	mov_s r1,0x111b
L_8e5860:
	bl.d L_8c82c0
L_8e5864:
	mov_s r3,0x84
L_8e5866:
	b_s L_8e582a
