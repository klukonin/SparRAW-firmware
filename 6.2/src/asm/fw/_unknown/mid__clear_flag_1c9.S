/* mid__clear_flag_1c9 @ 0x8c6948, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_ctrl__prepare_mid_fw, l2_mgr__connect_setup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__clear_flag_1c9
mid__clear_flag_1c9:
	.global L_8c6948
L_8c6948:
	mov_s r1,0x0
L_8c694a:
	add r0,r0,0x1c9
L_8c694e:
	j_s.d [blink]
L_8c6950:
	stb_s r1,[r0]
L_8c6952:
	nop_s
