/* wmi_handler_add_debug_tx_pckt @ 0x8e09ac, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CMD TX DATA failed - No CID found for sta %d
 *   CMD TX DATA of %d bytes g_fw_2_fw_test = %d.
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: TX_API__alloc_tx_payload, TX_API__send_packet, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_log__emit2, ie_list__first, mid_list__by_mid
 * Глобалы (через gp): 0x800344
 */
	.section .text.wmi_handler_add_debug_tx_pckt,"ax",@progbits
	.global wmi_handler_add_debug_tx_pckt
wmi_handler_add_debug_tx_pckt:
	.global L_8e09ac
L_8e09ac:
	push_s blink
L_8e09ae:
	bl L_8c02bc
L_8e09b2:
	sub_s sp,sp,0xc
L_8e09b4:
	mov_s r14,r0
L_8e09b6:
	bl.d L_8c2c80
L_8e09ba:
	mov_s r16,r1
L_8e09bc:
	mov_s r15,r0
L_8e09be:
	bl.d L_8ca1b0
L_8e09c2:
	mov_s r0,r16
L_8e09c4:
	bl.d L_8c9e10
L_8e09c8:
	ld_s r1,[r14,0x4]
L_8e09ca:
	mov.f r13,r0
L_8e09ce:
	bne_s L_8e09e2
L_8e09d0:
	mov_s r2,0x100a510
L_8e09d6:
	mov_s r0,0x7
L_8e09d8:
	mov_s r1,0x2
L_8e09da:
	bl.d L_8edfcc
L_8e09de:
	ld_s r3,[r14,0x4]
L_8e09e0:
	b_s L_8e0a20
	.global L_8e09e2
L_8e09e2:
	mov_s r0,0x1
L_8e09e4:
	st.as r0,[gp,0x75]
L_8e09e8:
	ld_s r3,[r14]
L_8e09ea:
	mov_s r2,0x100a540
L_8e09f0:
	mov_s r0,0x7
L_8e09f2:
	mov_s r1,0x2
L_8e09f4:
	bl.d L_8edff8
L_8e09f8:
	mov r4,0x1
L_8e09fc:
	ldw r4,[r14]
L_8e0a00:
	ldw r5,[r14, 0x8]
L_8e0a04:
	ldb r6,[r14, 0x14]
L_8e0a08:
	ldb_s r0,[r14,0xc]
L_8e0a0a:
	ldb r7,[r14, 0x15]
L_8e0a0e:
	st_s r0,[sp,0x0]
L_8e0a10:
	mov_s r1,0x0
L_8e0a12:
	st_s r1,[sp,0x4]
L_8e0a14:
	st_s r1,[sp,0x8]
L_8e0a16:
	mov_s r0,r13
L_8e0a18:
	mov_s r2,0x2
L_8e0a1a:
	bl.d L_8e0c74
L_8e0a1e:
	mov_s r3,r15
	.global L_8e0a20
L_8e0a20:
	b.d L_8c0324
L_8e0a24:
	add_s sp,sp,0xc
L_8e0a26:
	nop_s
