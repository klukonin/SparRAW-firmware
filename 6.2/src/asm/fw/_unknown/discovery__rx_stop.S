/* discovery__rx_stop @ 0x8f80ec, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery::rx_stop()
 * Зовут его: find_sm__stop_discovery, scan_mngr__scan_done, tof_mgr, tof_mgr__ftm_error_handler, tof_mgr__ftm_req_done
 * Зовёт сам: fw_log_emit0, hwd_mac_parser__set_rx_filter, mac_parser__set_886260
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global discovery__rx_stop
discovery__rx_stop:
	.global L_8f80ec
L_8f80ec:
	push_s blink
L_8f80ee:
	mov_s r1,0x1016fb0
L_8f80f4:
	bl.d L_8dcba8
L_8f80f8:
	mov_s r0,0x2c
L_8f80fa:
	mov_s r0,0x2
L_8f80fc:
	bl.d L_8dfbbc
L_8f8100:
	mov r1,0x102
L_8f8104:
	mov_s r0,0x3
L_8f8106:
	bl.d L_8dfbbc
L_8f810a:
	mov r1,0x102
L_8f810e:
	mov_s r0,0x0
L_8f8110:
	bl.d L_8dfd14
L_8f8114:
	mov_s r1,r0
L_8f8116:
	pop_s blink
L_8f8118:
	j_s [blink]
L_8f811a:
	nop_s
