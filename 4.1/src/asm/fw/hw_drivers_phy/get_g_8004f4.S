/* get_g_8004f4 @ 0x8cf8c0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_monitor__task_step
 */
	.section .text.get_g_8004f4,"ax",@progbits
	.global get_g_8004f4
get_g_8004f4:
	.global L_8cf8c0
L_8cf8c0:
	mov_s r0,0x8004f4
L_8cf8c6:
	j_s.d [blink]
L_8cf8c8:
	ld_s r0,[r0]
L_8cf8ca:
	nop_s
