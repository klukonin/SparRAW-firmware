/* __st_r16_to_r13 @ 0x92022c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__reset_sta, bf_req__dequeue_head, brp_restore_sectors, cf_end__send_frame, grant_detect_step, mac_q__tx_ppdu, mtp_queue__release_mgmt, peer_masks__or_into_8571c4, rate_search__pick_tx_params, rx_nav__set_from_duration
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global __st_r16_to_r13
__st_r16_to_r13:
	.global L_92022c
L_92022c:
	st.a r16,[sp,-0x4]
