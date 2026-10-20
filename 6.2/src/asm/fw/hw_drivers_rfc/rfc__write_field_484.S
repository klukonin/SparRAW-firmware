/* rfc__write_field_484 @ 0x8d3f80, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__step, lo_power__restore_rfc_field
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__write_field_484
rfc__write_field_484:
	.global L_8d3f80
L_8d3f80:
	push_s blink
L_8d3f82:
	bl L_8c01e4
L_8d3f86:
	mov_s r14,r1
L_8d3f88:
	extb_s r13,r0
L_8d3f8a:
	mov_s r0,r13
L_8d3f8c:
	mov r1,0x1e4
L_8d3f90:
	bl.d L_8d4308
L_8d3f94:
	ld_s r2,[r14]
L_8d3f96:
	mov_s r0,r13
L_8d3f98:
	mov r1,0x1e8
L_8d3f9c:
	bl.d L_8d4308
L_8d3fa0:
	ld_s r2,[r14,0x4]
L_8d3fa2:
	mov_s r0,r13
L_8d3fa4:
	mov r1,0x1ec
L_8d3fa8:
	bl.d L_8d4308
L_8d3fac:
	ld_s r2,[r14,0x8]
L_8d3fae:
	b L_8c0254
L_8d3fb2:
	nop_s
