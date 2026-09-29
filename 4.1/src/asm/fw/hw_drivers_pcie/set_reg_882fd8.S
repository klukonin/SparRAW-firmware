/* set_reg_882fd8 @ 0x8ce928, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.set_reg_882fd8,"ax",@progbits
	.global set_reg_882fd8
set_reg_882fd8:
	.global L_8ce928
L_8ce928:
	mov_s r0,0x882f80
L_8ce92e:
	st 0x80000,[r0, 0x58]
L_8ce936:
	j_s [blink]
