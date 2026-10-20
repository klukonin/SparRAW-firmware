/* wmi_tof_get_tx_rx_offset @ 0x8ccf7c, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_TOF_GET_TX_RX_OFFSET_EVENTID tof_tx_offset=%d, tof_rx_offset=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, mem_pool__alloc_locked, memset0_words, tof__get_rx_offset, tof__get_tx_offset, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_tof_get_tx_rx_offset
wmi_tof_get_tx_rx_offset:
	.global L_8ccf7c
L_8ccf7c:
	push_s blink
L_8ccf7e:
	bl L_8c01dc
L_8ccf82:
	sub_s sp,sp,0x4
L_8ccf84:
	mov_s r15,r0
L_8ccf86:
	bl.d L_8c33d0
L_8ccf8a:
	mov_s r16,r1
L_8ccf8c:
	mov_s r14,r0
L_8ccf8e:
	bl.d L_8c1cd8
L_8ccf92:
	mov_s r1,0x14
L_8ccf94:
	mov_s r13,0x0
L_8ccf96:
	bl.d L_8d46ac
L_8ccf9a:
	stb_s r13,[r14]
L_8ccf9c:
	bl.d L_8d46a0
L_8ccfa0:
	st_s r0,[r14,0x4]
L_8ccfa2:
	mov_s r3,r0
L_8ccfa4:
	st_s r0,[r14,0x8]
L_8ccfa6:
	mov_s r1,0x10062c4
L_8ccfac:
	mov_s r0,0x25
L_8ccfae:
	bl.d L_8dcc80
L_8ccfb2:
	ld_s r2,[r14,0x4]
L_8ccfb4:
	st_s r13,[sp,0x0]
L_8ccfb6:
	mov_s r0,r15
L_8ccfb8:
	mov_s r1,r14
L_8ccfba:
	mov_s r2,r13
L_8ccfbc:
	mov_s r3,0x1998
L_8ccfc2:
	mov r4,0x14
L_8ccfc6:
	mov r5,r16
L_8ccfca:
	mov_s r6,r13
L_8ccfcc:
	bl.d L_8e4fc4
L_8ccfd0:
	mov_s r7,r13
L_8ccfd2:
	b.d L_8c0244
L_8ccfd6:
	add_s sp,sp,0x4
