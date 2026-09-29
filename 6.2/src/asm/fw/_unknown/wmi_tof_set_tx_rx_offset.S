/* wmi_tof_set_tx_rx_offset @ 0x8e71a8, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_TOF_SET_TX_RX_OFFSET_EVENTID
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, hwm__alloc_and_store, mem_pool__alloc_locked, memset0_words, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_tof_set_tx_rx_offset
wmi_tof_set_tx_rx_offset:
	.global L_8e71a8
L_8e71a8:
	push_s blink
L_8e71aa:
	bl L_8c01dc
L_8e71ae:
	sub_s sp,sp,0x4
L_8e71b0:
	mov_s r15,r0
L_8e71b2:
	mov_s r16,r2
L_8e71b4:
	ld_s r0,[r1]
L_8e71b6:
	bl.d L_8dbea8
L_8e71ba:
	ld_s r1,[r1,0x4]
L_8e71bc:
	bl.d L_8c33d0
L_8e71c0:
	mov_s r0,r15
L_8e71c2:
	mov_s r13,r0
L_8e71c4:
	bl.d L_8c1cd8
L_8e71c8:
	mov_s r1,0x4
L_8e71ca:
	mov_s r14,0x0
L_8e71cc:
	stb_s r14,[r13]
L_8e71ce:
	mov_s r1,0x100628c
L_8e71d4:
	bl.d L_8dcba8
L_8e71d8:
	mov_s r0,0x25
L_8e71da:
	st_s r14,[sp,0x0]
L_8e71dc:
	mov_s r0,r15
L_8e71de:
	mov_s r1,r13
L_8e71e0:
	mov_s r2,r14
L_8e71e2:
	mov_s r3,0x1997
L_8e71e8:
	mov r4,0x4
L_8e71ec:
	mov r5,r16
L_8e71f0:
	mov_s r6,r14
L_8e71f2:
	bl.d L_8e4fc4
L_8e71f6:
	mov_s r7,r14
L_8e71f8:
	b.d L_8c0244
L_8e71fc:
	add_s sp,sp,0x4
L_8e71fe:
	nop_s
