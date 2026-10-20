/* get_g_804010 @ 0x928fa0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_flow_step, mac_mode_brp_step, mac_mode_step_b, rx_flow__handle_frame
 */
	.section .text.get_g_804010,"ax",@progbits
	.global get_g_804010
get_g_804010:
	.global L_928fa0
L_928fa0:
	mov_s r1,0x804010
L_928fa6:
	ldb_s r0,[r1,0x18]
L_928fa8:
	brne.d r0,0x14,L_928fb8
L_928fac:
	mov_s r3,0x0
L_928fae:
	ldb_s r2,[r1,0x19]
L_928fb0:
	cmp r2,0x1
L_928fb4:
	mov.eq r3,0x1
	.global L_928fb8
L_928fb8:
	j.d [blink]
