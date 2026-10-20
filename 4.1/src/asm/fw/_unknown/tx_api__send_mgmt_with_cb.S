/* tx_api__send_mgmt_with_cb @ 0x8e0e08, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm__assoc_req_handle, mlme_sm__send_assoc
 * Зовёт сам: TX_API__send_packet, __ld_r15_to_r13_ret, __st_r15_to_r13, get_g_800240
 */
	.section .text.tx_api__send_mgmt_with_cb,"ax",@progbits
	.global tx_api__send_mgmt_with_cb
tx_api__send_mgmt_with_cb:
	.global L_8e0e08
L_8e0e08:
	push_s blink
L_8e0e0a:
	bl.d L_8c02c0
L_8e0e0e:
	mov r11,r6
L_8e0e12:
	sub_s sp,sp,0xc
L_8e0e14:
	mov_s r15,r0
L_8e0e16:
	mov_s r14,r5
L_8e0e18:
	bl.d L_8ca1a4
L_8e0e1c:
	mov_s r13,r7
L_8e0e1e:
	mov_s r5,r0
L_8e0e20:
	mov_s r0,0x0
L_8e0e22:
	st_s r0,[sp,0x0]
L_8e0e24:
	ld_s r0,[sp,0x1c]
L_8e0e26:
	st_s r13,[sp,0x4]
L_8e0e28:
	st_s r0,[sp,0x8]
L_8e0e2a:
	mov_s r0,r15
L_8e0e2c:
	mov_s r6,r14
L_8e0e2e:
	bl.d L_8e0c74
L_8e0e32:
	mov r7,r11
L_8e0e36:
	b.d L_8c032c
L_8e0e3a:
	add_s sp,sp,0xc
