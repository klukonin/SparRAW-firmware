/* rm_sm__action_at_2c @ 0x8e6d34, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_sm__action_8e9ad4
 * Зовёт сам: __ld_r13_to_r13_ret, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_sm__action_at_2c
rm_sm__action_at_2c:
	.global L_8e6d34
L_8e6d34:
	push_s blink
L_8e6d36:
	push_s r13
L_8e6d38:
	mov_s r13,r0
L_8e6d3a:
	add_s r0,r0,0x2c
L_8e6d3c:
	bl.d L_8c0380
L_8e6d40:
	mov_s r2,0x28
L_8e6d42:
	mov_s r0,0x1
L_8e6d44:
	b.d L_8c025c
L_8e6d48:
	st_s r0,[r13,0x40]
L_8e6d4a:
	nop_s
