/* tx_api__send_mgmt_with_cb @ 0x8e5a28, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm_802458__action_8c5cfc, mlme_sm_802458__action_8f1080, state_sm_803424__action_8f064c
 * Зовёт сам: TX_API__send_packet, __ld_r15_to_r13_ret, __st_r15_to_r13, tx_api__get_mgmt_retry_limit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__send_mgmt_with_cb
tx_api__send_mgmt_with_cb:
	.global L_8e5a28
L_8e5a28:
	push_s blink
L_8e5a2a:
	bl.d L_8c01e0
L_8e5a2e:
	mov r11,r6
L_8e5a32:
	sub_s sp,sp,0xc
L_8e5a34:
	mov_s r15,r0
L_8e5a36:
	mov_s r14,r5
L_8e5a38:
	bl.d L_8cc3d0
L_8e5a3c:
	mov_s r13,r7
L_8e5a3e:
	mov_s r5,r0
L_8e5a40:
	mov_s r0,0x0
L_8e5a42:
	st_s r0,[sp,0x0]
L_8e5a44:
	ld_s r0,[sp,0x1c]
L_8e5a46:
	st_s r13,[sp,0x4]
L_8e5a48:
	st_s r0,[sp,0x8]
L_8e5a4a:
	mov_s r0,r15
L_8e5a4c:
	mov_s r6,r14
L_8e5a4e:
	bl.d L_8e58a4
L_8e5a52:
	mov r7,r11
L_8e5a56:
	b.d L_8c024c
L_8e5a5a:
	add_s sp,sp,0xc
