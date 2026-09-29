/* lmac_if__send_fw_ready_evt @ 0x8f3d80, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_FW_READY_EVENTID
 * Зовут его: lmac_if__lmac_ready_evt
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, host_if__send_pair, host_irq__raise_fw_ready, low_sme__send_evt2sw, pcie__set_event_bit_0_fw_ready
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_fw_ready_evt
lmac_if__send_fw_ready_evt:
	.global L_8f3d80
L_8f3d80:
	push_s blink
L_8f3d82:
	bl.d L_8d0cf4
L_8f3d86:
	push_s r13
L_8f3d88:
	bl L_8d1af8
L_8f3d8c:
	bl L_8c32d8
L_8f3d90:
	mov_s r1,0x1000c90
L_8f3d96:
	mov_s r13,r0
L_8f3d98:
	bl.d L_8dcba8
L_8f3d9c:
	mov_s r0,0x20
L_8f3d9e:
	mov_s r0,r13
L_8f3da0:
	mov_s r1,0x1801
L_8f3da6:
	mov_s r2,0x4
L_8f3da8:
	mov_s r3,0x0
L_8f3daa:
	mov_s r4,r3
L_8f3dac:
	mov_s r5,r3
L_8f3dae:
	bl.d L_8e5474
L_8f3db2:
	mov_s r6,r3
L_8f3db4:
	b L_8c025c
