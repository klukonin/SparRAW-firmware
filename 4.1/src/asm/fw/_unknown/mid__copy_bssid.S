/* mid__copy_bssid @ 0x8c9ae4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__connect_rf_kill, host_if__get_status_hal, mgmt_tx__build_mac_header, mgmt_tx__set_frame_control, tx_send_packet_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.mid__copy_bssid,"ax",@progbits
	.global mid__copy_bssid
mid__copy_bssid:
	.global L_8c9ae4
L_8c9ae4:
	push_s blink
L_8c9ae6:
	mov_s r2,r0
L_8c9ae8:
	mov_s r0,r1
L_8c9aea:
	ld_s r1,[r2,0x4]
L_8c9aec:
	brne r1,0x2,L_8c9afc
L_8c9af0:
	add r1,r2,0xc
L_8c9af4:
	bl.d L_8c0460
L_8c9af8:
	mov_s r2,0x6
L_8c9afa:
	b_s L_8c9b06
	.global L_8c9afc
L_8c9afc:
	ld_s r1,[r2]
L_8c9afe:
	add_s r1,r1,0xa
L_8c9b00:
	bl.d L_8c0460
L_8c9b04:
	mov_s r2,0x6
	.global L_8c9b06
L_8c9b06:
	pop_s blink
L_8c9b08:
	j_s [blink]
L_8c9b0a:
	nop_s
