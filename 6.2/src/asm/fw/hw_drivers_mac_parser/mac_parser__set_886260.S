/* mac_parser__set_886260 @ 0x8dfbbc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__rx_start, discovery__rx_stop, l2_mgr__pcp_start_flow, mac_parser__configure
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__set_886260
mac_parser__set_886260:
	.global L_8dfbbc
L_8dfbbc:
	mov_s r2,0x886260
L_8dfbc2:
	add2_s r2,r2,r0
L_8dfbc4:
	st_s r1,[r2]
L_8dfbc6:
	j_s [blink]
