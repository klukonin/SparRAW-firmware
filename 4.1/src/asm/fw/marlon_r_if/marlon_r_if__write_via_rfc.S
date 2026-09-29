/* marlon_r_if__write_via_rfc @ 0x8e7fb0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: marlon_r_if__write_reg
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, tail_rfc_field_write
 */
	.section .text.marlon_r_if__write_via_rfc,"ax",@progbits
	.global marlon_r_if__write_via_rfc
marlon_r_if__write_via_rfc:
	.global L_8e7fb0
L_8e7fb0:
	push_s blink
L_8e7fb2:
	bl L_8c02b8
L_8e7fb6:
	mov_s r17,r0
L_8e7fb8:
	mov_s r16,r1
L_8e7fba:
	mov.f r13,r4
L_8e7fbe:
	mov_s r14,r2
L_8e7fc0:
	mov_s r15,r3
L_8e7fc2:
	beq_s L_8e7fd6
	.global L_8e7fc4
L_8e7fc4:
	mov_s r0,r17
L_8e7fc6:
	mov_s r1,r16
L_8e7fc8:
	mov_s r2,r14
L_8e7fca:
	bl.d L_8e8008
L_8e7fce:
	mov_s r3,r15
L_8e7fd0:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e7fd2:
	brhs r13,0x1,L_8e7fc4
	.global L_8e7fd6
L_8e7fd6:
	b L_8c031c
L_8e7fda:
	nop_s
