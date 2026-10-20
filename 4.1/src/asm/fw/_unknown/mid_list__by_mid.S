/* mid_list__by_mid @ 0x8ca1b0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: MAINTAIN_SM__OPEN, SW_TX_MGMT_API__send_packet, WMI_ADD_CIPHER_KEY_CMD, bcon_ctrl__prepare_mid, disconnect_by_peer, find_mng__add_bcon, frag_8f1908, host_if__connect_rf_kill, host_if__get_status_hal, info_flow__start_periodic
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__has_more, iter__init, iter__next
 */
	.section .text.mid_list__by_mid,"ax",@progbits
	.global mid_list__by_mid
mid_list__by_mid:
	.global L_8ca1b0
L_8ca1b0:
	push_s blink
L_8ca1b2:
	bl L_8c02c4
L_8ca1b6:
	sub_s sp,sp,0x4
L_8ca1b8:
	mov_s r14,r0
L_8ca1ba:
	mov_s r13,sp
L_8ca1bc:
	mov_s r1,0x8058d0
L_8ca1c2:
	bl.d L_8e1138
L_8ca1c6:
	mov_s r0,r13
L_8ca1c8:
	b_s L_8ca1d6
	.global L_8ca1ca
L_8ca1ca:
	bl.d L_8db188
L_8ca1ce:
	mov_s r0,r13
L_8ca1d0:
	ldb_s r1,[r0,0x10]
L_8ca1d2:
	breq r14,r1,L_8ca1e0
	.global L_8ca1d6
L_8ca1d6:
	bl.d L_8cb674
L_8ca1da:
	mov_s r0,r13
L_8ca1dc:
	brne_s r0,0,L_8ca1ca
L_8ca1de:
	mov_s r0,0x0
	.global L_8ca1e0
L_8ca1e0:
	b.d L_8c0334
L_8ca1e4:
	add_s sp,sp,0x4
L_8ca1e6:
	nop_s
