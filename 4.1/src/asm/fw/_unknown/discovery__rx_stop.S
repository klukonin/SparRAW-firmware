/* discovery__rx_stop @ 0x8efdac, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery::rx_stop()
 * Зовут его: find_sm__stop_discovery, scan_mngr__scan_done
 * Зовёт сам: fw_log__emit0, hwd_mac_parser__set_rx_filter, mac_parser__set_886260
 */
	.section .text.discovery__rx_stop,"ax",@progbits
	.global discovery__rx_stop
discovery__rx_stop:
	.global L_8efdac
L_8efdac:
	push_s blink
L_8efdae:
	mov_s r2,0x1012800
L_8efdb4:
	mov_s r0,0xc
L_8efdb6:
	bl.d L_8edfb0
L_8efdba:
	mov_s r1,0x2
L_8efdbc:
	mov_s r0,0x2
L_8efdbe:
	bl.d L_8dbae4
L_8efdc2:
	mov r1,0x102
L_8efdc6:
	mov_s r0,0x3
L_8efdc8:
	bl.d L_8dbae4
L_8efdcc:
	mov r1,0x102
L_8efdd0:
	mov_s r0,0x0
L_8efdd2:
	bl.d L_8dbc3c
L_8efdd6:
	mov_s r1,r0
L_8efdd8:
	pop_s blink
L_8efdda:
	j_s [blink]
