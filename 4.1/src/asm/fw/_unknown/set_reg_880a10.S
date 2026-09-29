/* set_reg_880a10 @ 0x8ebbf4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_boot__log_versions
 */
	.section .text.set_reg_880a10,"ax",@progbits
	.global set_reg_880a10
set_reg_880a10:
	.global L_8ebbf4
L_8ebbf4:
	mov_s r1,0x880a00
L_8ebbfa:
	j_s.d [blink]
L_8ebbfc:
	st_s r0,[r1,0x10]
L_8ebbfe:
	nop_s
