/* power_mngr__post_evt5 @ 0x8c3e90, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dmg_bcon__rx_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mngr__post_evt5
power_mngr__post_evt5:
	.global L_8c3e90
L_8c3e90:
	mov_s r2,r0
L_8c3e92:
	ld_s r0,[gp,-0x64]
L_8c3e94:
	ld_s r1,[r0,0x8]
L_8c3e96:
	ld_s r3,[r1,0x8]
L_8c3e98:
	j_s.d [r3]
L_8c3e9a:
	mov_s r1,0x5
