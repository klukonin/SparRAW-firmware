/* lmac_if__send_fw_ready_evt @ 0x8cb6d8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_FW_READY_EVENTID
 * Зовут его: lmac_if__lmac_ready_evt
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, operational_if__alloc_evt, operational_if__send_evt, tail_hwd_dma__kick_channel_8cdf94, tail_pcie__set_event_bit_8cee50
 */
	.section .text.lmac_if__send_fw_ready_evt,"ax",@progbits
	.global lmac_if__send_fw_ready_evt
lmac_if__send_fw_ready_evt:
	.global L_8cb6d8
L_8cb6d8:
	push_s blink
L_8cb6da:
	bl.d L_8cdf94
L_8cb6de:
	push_s r13
L_8cb6e0:
	bl L_8cee50
L_8cb6e4:
	bl L_8c2b68
L_8cb6e8:
	mov_s r2,0x1000c8c
L_8cb6ee:
	mov_s r13,r0
L_8cb6f0:
	mov_s r0,0x0
L_8cb6f2:
	bl.d L_8edfb0
L_8cb6f6:
	mov_s r1,0x2
L_8cb6f8:
	mov_s r0,r13
L_8cb6fa:
	mov_s r1,0x1801
L_8cb700:
	mov_s r2,0x4
L_8cb702:
	mov_s r3,0x0
L_8cb704:
	mov r4,0x0
L_8cb708:
	bl.d L_8e0874
L_8cb70c:
	mov r5,0x0
L_8cb710:
	b L_8c033c
