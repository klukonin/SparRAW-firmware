/* vring__notify_delete @ 0x8e73ec, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__teardown
 * Зовёт сам: hwd_dma__read_ring_state
 */
	.section .text.vring__notify_delete,"ax",@progbits
	.global vring__notify_delete
vring__notify_delete:
	.global L_8e73ec
L_8e73ec:
	mov_s r1,r0
L_8e73ee:
	ld_s r0,[gp,-0xec]
L_8e73f0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e73f2:
	st.as r0,[gp,-0x3b]
L_8e73f6:
	ldw_s r0,[r1,0x2]
L_8e73f8:
	b.d L_8d1644
L_8e73fc:
	ldw_s r1,[r1]
L_8e73fe:
	nop_s
