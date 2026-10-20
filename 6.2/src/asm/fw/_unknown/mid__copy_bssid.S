/* mid__copy_bssid @ 0x8cbb58, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__connect_rf_kill, host_if__get_status_hal, mgmt_tx__build_mac_header, mgmt_tx__set_frame_control, tx_send_packet_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__copy_bssid
mid__copy_bssid:
	.global L_8cbb58
L_8cbb58:
	push_s blink
L_8cbb5a:
	mov_s r2,r0
L_8cbb5c:
	mov_s r0,r1
L_8cbb5e:
	ld_s r1,[r2,0x4]
L_8cbb60:
	brne r1,0x2,L_8cbb70
L_8cbb64:
	add r1,r2,0xc
L_8cbb68:
	bl.d L_8c0380
L_8cbb6c:
	mov_s r2,0x6
L_8cbb6e:
	b_s L_8cbb7a
	.global L_8cbb70
L_8cbb70:
	ld_s r1,[r2]
L_8cbb72:
	add_s r1,r1,0xa
L_8cbb74:
	bl.d L_8c0380
L_8cbb78:
	mov_s r2,0x6
	.global L_8cbb7a
L_8cbb7a:
	pop_s blink
L_8cbb7c:
	j_s [blink]
L_8cbb7e:
	nop_s
