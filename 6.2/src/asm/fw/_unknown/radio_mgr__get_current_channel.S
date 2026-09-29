/* radio_mgr__get_current_channel @ 0x8cc130, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channels_switch_sm__action_pop_ch_and_tune, discovery__tsf_wa, ftm_main_sm__action_pop_ch_and_tune, mid__link_acquis_step, rx_pkt__lookup_handler, scan_mngr__connect, sort_scan_ch_list, tof__find_session_by_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_mgr__get_current_channel
radio_mgr__get_current_channel:
	.global L_8cc130
L_8cc130:
	mov_s r1,r0
L_8cc132:
	ld_s r0,[gp,-0x40]
L_8cc134:
	ld_s r2,[r0]
L_8cc136:
	ld_s r2,[r2,0x1c]
L_8cc138:
	j_s [r2]
L_8cc13a:
	nop_s
