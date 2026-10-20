/* scan_mngr__stop_dwelling @ 0x8f9b24, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::stop_dwelling()
 * Зовут его: l2_mgr__lmac_new_link_evt_handler
 * Зовёт сам: __ld_r13_to_r13_ret, channels_switch_sm__action_abort_dwelling, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__stop_dwelling
scan_mngr__stop_dwelling:
	.global L_8f9b24
L_8f9b24:
	push_s blink
L_8f9b26:
	push_s r13
L_8f9b28:
	mov_s r13,r0
L_8f9b2a:
	mov_s r1,0x1016398
L_8f9b30:
	bl.d L_8dcba8
L_8f9b34:
	mov_s r0,0x29
L_8f9b36:
	ld r0,[r13, 0x80]
L_8f9b3a:
	mov_s r1,0x0
L_8f9b3c:
	mov_s r2,r1
L_8f9b3e:
	bl.d L_8c203c
L_8f9b42:
	mov_s r3,r1
L_8f9b44:
	b L_8c025c
