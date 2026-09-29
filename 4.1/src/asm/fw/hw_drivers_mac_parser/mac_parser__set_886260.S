/* mac_parser__set_886260 @ 0x8dbae4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__rx_start, discovery__rx_stop, l2_mgr__pcp_start_flow, mac_parser__configure
 */
	.section .text.mac_parser__set_886260,"ax",@progbits
	.global mac_parser__set_886260
mac_parser__set_886260:
	.global L_8dbae4
L_8dbae4:
	mov_s r2,0x886260
L_8dbaea:
	add2_s r2,r2,r0
L_8dbaec:
	st_s r1,[r2]
L_8dbaee:
	j_s [blink]
