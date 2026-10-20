/* set_reg_880a48 @ 0x8e35d8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysassert_fatal
 */
	.section .text.set_reg_880a48,"ax",@progbits
	.global set_reg_880a48
set_reg_880a48:
	.global L_8e35d8
L_8e35d8:
	mov_s r1,0x880a3c
L_8e35de:
	j_s.d [blink]
L_8e35e0:
	st_s r0,[r1,0xc]
L_8e35e2:
	nop_s
