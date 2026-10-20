/* get_g_800118_8c34e8 @ 0x8c34e8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__handle_rx_frame
 */
	.section .text.get_g_800118_8c34e8,"ax",@progbits
	.global get_g_800118_8c34e8
get_g_800118_8c34e8:
	.global L_8c34e8
L_8c34e8:
	mov_s r2,r0
L_8c34ea:
	ld_s r0,[gp,-0x58]
L_8c34ec:
	ld_s r1,[r0,0x8]
L_8c34ee:
	ld_s r3,[r1,0x8]
L_8c34f0:
	j_s.d [r3]
L_8c34f2:
	mov_s r1,0x5
