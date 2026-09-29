/* marlon_r_if_class__rf_hw_write_buffer @ 0x8dea6c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::rf_hw_write_buffer: not performing any write(num_values = %d)
 * Зовут его: marlon_r_if_class__rf_write_with_block_retries
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, rfc__write_buffer_and_wait
 */
	.section .text.marlon_r_if_class__rf_hw_write_buffer,"ax",@progbits
	.global marlon_r_if_class__rf_hw_write_buffer
marlon_r_if_class__rf_hw_write_buffer:
	.global L_8dea6c
L_8dea6c:
	push_s blink
L_8dea6e:
	bl L_8c02c0
L_8dea72:
	mov_s r15,r2
L_8dea74:
	breq_s r3,0,L_8dea9a
L_8dea76:
	brlo.d r3,0x1,L_8dea96
L_8dea7a:
	mov_s r13,0x0
L_8dea7c:
	mov_s r14,r3
	.global L_8dea7e
L_8dea7e:
	add3 r3,r15,r13
L_8dea82:
	mov_s r0,0x0
L_8dea84:
	ld_s r2,[r3]
L_8dea86:
	mov_s r1,r0
L_8dea88:
	bl.d L_8e85b0
L_8dea8c:
	ld_s r3,[r3,0x4]
L_8dea8e:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8dea90:
	/* brhs.d r14,0x1,0x008dea7e */
	.byte 0xef,0x0e,0x75,0x90
L_8dea94:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8dea96
L_8dea96:
	b L_8c032c
	.global L_8dea9a
L_8dea9a:
	mov_s r2,0x10056b0
L_8deaa0:
	mov_s r0,0x0
L_8deaa2:
	bl.d L_8edfcc
L_8deaa6:
	mov_s r1,0x2
L_8deaa8:
	b_s L_8dea96
L_8deaaa:
	nop_s
