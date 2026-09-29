/* mid__clear_flag_1c9 @ 0x8c5b88, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_ctrl__prepare_mid, l2_mgr__connect_setup
 */
	.section .text.mid__clear_flag_1c9,"ax",@progbits
	.global mid__clear_flag_1c9
mid__clear_flag_1c9:
	.global L_8c5b88
L_8c5b88:
	mov_s r1,0x0
L_8c5b8a:
	add r0,r0,0x1c9
L_8c5b8e:
	j_s.d [blink]
L_8c5b90:
	stb_s r1,[r0]
L_8c5b92:
	nop_s
