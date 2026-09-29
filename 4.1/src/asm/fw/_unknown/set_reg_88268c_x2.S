/* set_reg_88268c_x2 @ 0x8f2910, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__ACTIVATING
 */
	.section .text.set_reg_88268c_x2,"ax",@progbits
	.global set_reg_88268c_x2
set_reg_88268c_x2:
	.global L_8f2910
L_8f2910:
	mov r1,0x200
L_8f2914:
	mov_s r0,0x882680
L_8f291a:
	st_s r1,[r0,0xc]
L_8f291c:
	st_s r1,[r0,0x20]
L_8f291e:
	j_s [blink]
