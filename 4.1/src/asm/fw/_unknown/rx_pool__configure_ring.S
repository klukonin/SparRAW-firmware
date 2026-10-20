/* rx_pool__configure_ring @ 0x8d5dbc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pool__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dma_mgr__configure_ring, mid__attach_rx_pool
 */
	.section .text.rx_pool__configure_ring,"ax",@progbits
	.global rx_pool__configure_ring
rx_pool__configure_ring:
	.global L_8d5dbc
L_8d5dbc:
	push_s blink
L_8d5dbe:
	/* bl.d 0x008c02c0 */
	.byte 0x06,0x0d,0x2f,0xf5
L_8d5dc2:
	/* _add_s r0,0x4 */
	.byte 0x04,0xe0
L_8d5dc4:
	mov_s r13,r1
L_8d5dc6:
	mov_s r15,r2
L_8d5dc8:
	bl.d L_8e1400
L_8d5dcc:
	mov_s r14,r3
L_8d5dce:
	bmsk r1,r13,0x11
L_8d5dd2:
	mov_s r0,r14
L_8d5dd4:
	mov_s r2,0x0
L_8d5dd6:
	mov_s r3,r15
L_8d5dd8:
	mov r4,0x1
L_8d5ddc:
	mov r5,r4
L_8d5de0:
	mov_s r6,r2
L_8d5de2:
	bl.d L_8c611c
L_8d5de6:
	mov_s r7,r2
L_8d5de8:
	b L_8c032c
