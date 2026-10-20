/* set_reg_886f84_x3 @ 0x926cd0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps__program_awake_peers_mask
 */
	.section .text.set_reg_886f84_x3,"ax",@progbits
	.global set_reg_886f84_x3
set_reg_886f84_x3:
	.global L_926cd0
L_926cd0:
	mov_s r3,0x887000
L_926cd6:
	st r1,[r3, -0x7c]
L_926cda:
	st r0,[0x88c050]
L_926ce2:
	st r2,[r3, -0x78]
L_926ce6:
	j_s [blink]
