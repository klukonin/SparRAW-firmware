/* set_reg_882fd0 @ 0x8ce8f8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__l1_idle_and_park
 */
	.section .text.set_reg_882fd0,"ax",@progbits
	.global set_reg_882fd0
set_reg_882fd0:
	.global L_8ce8f8
L_8ce8f8:
	mov_s r0,0x882f80
L_8ce8fe:
	st 0x80000,[r0, 0x50]
L_8ce906:
	j_s [blink]
