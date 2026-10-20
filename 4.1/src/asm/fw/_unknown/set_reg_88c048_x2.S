/* set_reg_88c048_x2 @ 0x8ce0fc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__program_mac_addr
 */
	.section .text.set_reg_88c048_x2,"ax",@progbits
	.global set_reg_88c048_x2
set_reg_88c048_x2:
	.global L_8ce0fc
L_8ce0fc:
	mov_s r1,0x0
L_8ce0fe:
	mov_s r0,0x88c000
L_8ce104:
	st_s r1,[r0,0x48]
L_8ce106:
	st 0x80001f00,[r0, 0x4c]
L_8ce10e:
	j_s [blink]
