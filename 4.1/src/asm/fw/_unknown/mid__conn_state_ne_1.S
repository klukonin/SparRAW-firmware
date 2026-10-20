/* mid__conn_state_ne_1 @ 0x8ed820, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__get_status_hal, l2mgr__data_port_open, l2mgr__install_key, l2mgr__notify_key_ready, low_sme__send_evt2sw, sw_vring__ba_agreed, vring__on_macq_delete_ntf, vring__wait_macq_delete
 */
	.section .text.mid__conn_state_ne_1,"ax",@progbits
	.global mid__conn_state_ne_1
mid__conn_state_ne_1:
	.global L_8ed820
L_8ed820:
	ld_s r0,[r0,0xc]
L_8ed822:
	ld_s r0,[r0,0x2c]
L_8ed824:
	cmp_s r0,0x1
L_8ed826:
	mov_s r0,0x1
L_8ed828:
	j_s.d [blink]
L_8ed82a:
	sub.eq r0,r0,r0
L_8ed82e:
	nop_s
