/* set_reg_886a00_x2 @ 0x8f28a4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 */
	.section .text.set_reg_886a00_x2,"ax",@progbits
	.global set_reg_886a00_x2
set_reg_886a00_x2:
	.global L_8f28a4
L_8f28a4:
	mov_s r0,0x5
L_8f28a6:
	mov_s r1,0x886a00
L_8f28ac:
	st_s r0,[r1]
L_8f28ae:
	mov_s r0,0x9
L_8f28b0:
	st_s r0,[r1,0x4]
L_8f28b2:
	j_s [blink]
