/* mlme_sm_8027a0__action_8f9ca8 @ 0x8f9ca8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DISC SM - spurious SW Data stopped notification.
 * Зовёт сам: WBE_DRIVER__CLOSE, __ld_r13_to_r13_ret, fw_log_emit0, lm_if__on_data_stopped
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_8027a0__action_8f9ca8
mlme_sm_8027a0__action_8f9ca8:
	.global L_8f9ca8
L_8f9ca8:
	push_s blink
L_8f9caa:
	push_s r13
L_8f9cac:
	mov_s r13,r0
L_8f9cae:
	ld_s r0,[r0,0xc]
L_8f9cb0:
	bbit0 r0,0x1,L_8f9cce
L_8f9cb4:
	bl L_8f9b68
L_8f9cb8:
	ld_s r0,[r13,0xc]
L_8f9cba:
	bic r0,r0,0x6
L_8f9cbe:
	bset_s r0,r0,0x2
L_8f9cc0:
	st_s r0,[r13,0xc]
L_8f9cc2:
	ld_s r0,[r13,0x8]
L_8f9cc4:
	ld_s r0,[r0,0x8]
L_8f9cc6:
	bl.d L_8e8014
L_8f9cca:
	add_s r0,r0,0x70
L_8f9ccc:
	b_s L_8f9cda
	.global L_8f9cce
L_8f9cce:
	mov_s r1,0x1011c20
L_8f9cd4:
	bl.d L_8dcba8
L_8f9cd8:
	mov_s r0,0x2b
	.global L_8f9cda
L_8f9cda:
	b L_8c025c
L_8f9cde:
	nop_s
