/* wmi_add_debug_tx_pckt @ 0x8e55ac, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CMD TX DATA failed - No CID found for sta %d
 *   CMD TX DATA of %d bytes g_fw_2_fw_test = %d.
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: TX_API__alloc_tx_payload, TX_API__send_packet, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_log_emit2, ie_list__first, mid_list__by_mid_fw
 * Глобалы (через gp): 0x800368
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_add_debug_tx_pckt
wmi_add_debug_tx_pckt:
	.global L_8e55ac
L_8e55ac:
	push_s blink
L_8e55ae:
	bl L_8c01dc
L_8e55b2:
	sub_s sp,sp,0xc
L_8e55b4:
	mov_s r13,r0
L_8e55b6:
	bl.d L_8c3414
L_8e55ba:
	mov_s r16,r1
L_8e55bc:
	mov_s r15,r0
L_8e55be:
	bl.d L_8cc3dc
L_8e55c2:
	mov_s r0,r16
L_8e55c4:
	bl.d L_8cbfc8
L_8e55c8:
	ld_s r1,[r13,0x4]
L_8e55ca:
	mov.f r14,r0
L_8e55ce:
	bne_s L_8e55e0
L_8e55d0:
	mov_s r1,0x100ba78
L_8e55d6:
	mov_s r0,0x27
L_8e55d8:
	bl.d L_8dcc10
L_8e55dc:
	ld_s r2,[r13,0x4]
L_8e55de:
	b_s L_8e5618
	.global L_8e55e0
L_8e55e0:
	mov_s r3,0x1
L_8e55e2:
	st.as r3,[gp,0x79]
L_8e55e6:
	mov_s r1,0x100baa8
L_8e55ec:
	mov_s r0,0x27
L_8e55ee:
	bl.d L_8dcc80
L_8e55f2:
	ld_s r2,[r13]
L_8e55f4:
	ldw r4,[r13]
L_8e55f8:
	ldw r5,[r13, 0x8]
L_8e55fc:
	ldb r6,[r13, 0x14]
L_8e5600:
	ldb_s r0,[r13,0xc]
L_8e5602:
	ldb r7,[r13, 0x15]
L_8e5606:
	st_s r0,[sp,0x0]
L_8e5608:
	mov_s r1,0x0
L_8e560a:
	st_s r1,[sp,0x4]
L_8e560c:
	st_s r1,[sp,0x8]
L_8e560e:
	mov_s r0,r14
L_8e5610:
	mov_s r2,0x2
L_8e5612:
	bl.d L_8e58a4
L_8e5616:
	mov_s r3,r15
	.global L_8e5618
L_8e5618:
	b.d L_8c0244
L_8e561c:
	add_s sp,sp,0xc
L_8e561e:
	nop_s
