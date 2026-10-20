/* connection__on_bf_result @ 0x8c4990, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   connection.cpp
 * Зовут его: lmac_if__abft_notify_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn__metric_average, conn__push_metric_sample, conn__threshold_to_offset, fw_sysassert_fatal
 */
	.section .text.connection__on_bf_result,"ax",@progbits
	.global connection__on_bf_result
connection__on_bf_result:
	.global L_8c4990
L_8c4990:
	push_s blink
L_8c4992:
	bl L_8c02c0
L_8c4996:
	mov.f r15,r1
L_8c499a:
	mov_s r14,r0
L_8c499c:
	mov_s r13,0x0
L_8c499e:
	bne_s L_8c49a8
L_8c49a0:
	mov_s r1,0x800f80
L_8c49a6:
	b_s L_8c49b2
	.global L_8c49a8
L_8c49a8:
	brne r15,0x1,L_8c49ba
L_8c49ac:
	mov_s r1,0x800f90
	.global L_8c49b2
L_8c49b2:
	bl.d L_8c653c
L_8c49b6:
	mov_s r0,r14
L_8c49b8:
	mov_s r13,r0
	.global L_8c49ba
L_8c49ba:
	brhs r15,0x3,L_8c49e6
	.global L_8c49be
L_8c49be:
	breq_s r15,0,L_8c49d0
L_8c49c0:
	mov_s r0,r14
L_8c49c2:
	bl.d L_8e23e0
L_8c49c6:
	mov_s r1,r13
L_8c49c8:
	bl.d L_8e2428
L_8c49cc:
	mov_s r0,r14
L_8c49ce:
	mov_s r13,r0
	.global L_8c49d0
L_8c49d0:
	add r14,r14,0x185
L_8c49d4:
	ld_s r0,[gp,-0x158]
L_8c49d6:
	stb_s r13,[r14]
L_8c49d8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c49da:
	st.as r0,[gp,-0x56]
L_8c49de:
	b.d L_8c032c
L_8c49e2:
	stb r13,[gp, 0xbe]
	.global L_8c49e6
L_8c49e6:
	mov_s r0,blink
L_8c49e8:
	mov_s r2,0x100e298
L_8c49ee:
	mov_s r1,0x11c1
L_8c49f4:
	bl.d L_8c82c0
L_8c49f8:
	mov r3,0x156
L_8c49fc:
	b_s L_8c49be
L_8c49fe:
	nop_s
