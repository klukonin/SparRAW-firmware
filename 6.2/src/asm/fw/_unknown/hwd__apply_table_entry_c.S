/* hwd__apply_table_entry_c @ 0x8f8f60, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd__apply_table_entry, hwd__apply_table_entry_b
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_lshr64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd__apply_table_entry_c
hwd__apply_table_entry_c:
	.global L_8f8f60
L_8f8f60:
	push_s blink
L_8f8f62:
	bl.d L_8c01dc
L_8f8f66:
	mov_s r0,r2
L_8f8f68:
	mov_s r14,r1
L_8f8f6a:
	mov_s r1,r3
L_8f8f6c:
	mov_s r15,r5
L_8f8f6e:
	mov.f r2,r15
L_8f8f72:
	mov r16,r4
L_8f8f76:
	mov_s r13,0x0
L_8f8f78:
	beq_s L_8f8f82
L_8f8f7a:
	norm r2,r2
L_8f8f7e:
	rsub r13,r2,0x1f
	.global L_8f8f82
L_8f8f82:
	bl.d L_8c0430
L_8f8f86:
	mov_s r2,r13
L_8f8f88:
	st_s r0,[r14]
L_8f8f8a:
	mov_s r0,r16
L_8f8f8c:
	mov_s r1,r15
L_8f8f8e:
	bl.d L_8c0430
L_8f8f92:
	mov_s r2,r13
L_8f8f94:
	b.d L_8c0244
L_8f8f98:
	st_s r0,[r14,0x4]
L_8f8f9a:
	nop_s
