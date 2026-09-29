/* rx_pool__configure_step @ 0x8e60d0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pool__configure_ring
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, rx_api__drain_all_lists, rx_pool__set_fields
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_pool__configure_step
rx_pool__configure_step:
	.global L_8e60d0
L_8e60d0:
	push_s blink
L_8e60d2:
	bl L_8c01e4
L_8e60d6:
	mov_s r13,r0
L_8e60d8:
	bl.d L_8d9394
L_8e60dc:
	mov_s r14,r3
L_8e60de:
	bl.d L_8e6c60
L_8e60e2:
	mov_s r0,r13
L_8e60e4:
	st_s r14,[r13,0x10]
L_8e60e6:
	mov_s r0,0x0
L_8e60e8:
	b.d L_8c0254
L_8e60ec:
	st_s r0,[r13,0x14]
L_8e60ee:
	nop_s
L_8e60f0:
	push_s blink
L_8e60f2:
	push_s r13
L_8e60f4:
	st_s r1,[r0,0x14]
L_8e60f6:
	st_s r2,[r0,0x18]
L_8e60f8:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8e60fa:
	mov_s r1,r3
L_8e60fc:
	bl.d L_8d9394
L_8e6100:
	mov_s r2,r4
L_8e6102:
	b L_8c025c
L_8e6106:
	nop_s
