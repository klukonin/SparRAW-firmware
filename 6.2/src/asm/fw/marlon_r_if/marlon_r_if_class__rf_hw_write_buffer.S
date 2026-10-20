/* marlon_r_if_class__rf_hw_write_buffer @ 0x8e33d8, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::rf_hw_write_buffer: not performing any write(num_values = %d)
 * Зовут его: marlon_r_if_class__rf_write_with_block_retries
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global marlon_r_if_class__rf_hw_write_buffer
marlon_r_if_class__rf_hw_write_buffer:
	.global L_8e33d8
L_8e33d8:
	push_s blink
L_8e33da:
	bl L_8c01e0
L_8e33de:
	mov_s r15,r2
L_8e33e0:
	mov.f r2,r3
L_8e33e4:
	beq_s L_8e3408
L_8e33e6:
	brlo.d r2,0x1,L_8e3404
L_8e33ea:
	mov_s r13,0x0
L_8e33ec:
	mov_s r14,r2
	.global L_8e33ee
L_8e33ee:
	add3 r2,r15,r13
L_8e33f2:
	ld_s r1,[r2]
L_8e33f4:
	mov_s r0,0x0
L_8e33f6:
	bl.d L_8d4308
L_8e33fa:
	ld_s r2,[r2,0x4]
L_8e33fc:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8e33fe:
	/* brhs.d r14,0x1,0x008e33ee */
	.byte 0xf3,0x0e,0x75,0x90
L_8e3402:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8e3404
L_8e3404:
	b L_8c024c
	.global L_8e3408
L_8e3408:
	mov_s r1,0x10054e4
L_8e340e:
	bl.d L_8dcc10
L_8e3412:
	mov_s r0,0x20
L_8e3414:
	b_s L_8e3404
L_8e3416:
	nop_s
