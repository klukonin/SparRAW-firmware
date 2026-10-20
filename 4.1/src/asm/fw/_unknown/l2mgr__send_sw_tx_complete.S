/* l2mgr__send_sw_tx_complete @ 0x8f0b44, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SW_TX_COMPLETE_EVENTID for devid %d (status %d).
 * Зовут его: wmi_handler_sw_tx_req
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, memset0_words, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_sw_tx_complete,"ax",@progbits
	.global l2mgr__send_sw_tx_complete
l2mgr__send_sw_tx_complete:
	.global L_8f0b44
L_8f0b44:
	push_s blink
L_8f0b46:
	bl L_8c02c0
L_8f0b4a:
	mov_s r15,r0
L_8f0b4c:
	bl.d L_8c2b68
L_8f0b50:
	mov_s r14,r1
L_8f0b52:
	mov_s r13,r0
L_8f0b54:
	bl.d L_8c1a78
L_8f0b58:
	mov_s r1,0x4
L_8f0b5a:
	stb_s r15,[r13]
L_8f0b5c:
	mov_s r2,0x100cd1c
L_8f0b62:
	mov_s r0,0xb
L_8f0b64:
	mov_s r1,0x2
L_8f0b66:
	mov_s r3,r14
L_8f0b68:
	bl.d L_8edff8
L_8f0b6c:
	mov_s r4,r15
L_8f0b6e:
	mov_s r0,r13
L_8f0b70:
	mov_s r1,0x182b
L_8f0b76:
	mov_s r2,0x4
L_8f0b78:
	mov_s r3,r14
L_8f0b7a:
	mov r4,0x0
L_8f0b7e:
	bl.d L_8e0874
L_8f0b82:
	mov r5,r4
L_8f0b86:
	b L_8c032c
L_8f0b8a:
	nop_s
