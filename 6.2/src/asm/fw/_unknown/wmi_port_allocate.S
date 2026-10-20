/* wmi_port_allocate @ 0x8fb77c, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Error in MAC address !!!
 *   <<---- [HOST EVENT] WMI_PORT_ALLOCATED_EVENTID for midid %d.
 *   Cannot open default MID !!!
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_log_emit1, host_if__send_pair, l2mgr__mac_started_log, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_port_allocate
wmi_port_allocate:
	.global L_8fb77c
L_8fb77c:
	push_s blink
L_8fb77e:
	bl L_8c01e0
L_8fb782:
	bl.d L_8c32d8
L_8fb786:
	mov_s r14,r0
L_8fb788:
	mov_s r13,r0
L_8fb78a:
	ldb_s r0,[r14,0x7]
L_8fb78c:
	breq_s r0,0,L_8fb7ec
L_8fb78e:
	ldb_s r1,[r14]
L_8fb790:
	bxor r1,r1,0x0
L_8fb794:
	bbit1 r1,0x0,L_8fb7a6
L_8fb798:
	mov_s r1,0x100e620
L_8fb79e:
	bl.d L_8dcba8
L_8fb7a2:
	mov_s r0,0xb
L_8fb7a4:
	b_s L_8fb7ba
	.global L_8fb7a6
L_8fb7a6:
	mov_s r1,r14
L_8fb7a8:
	mov_s r15,0x0
L_8fb7aa:
	mov_s r2,r15
L_8fb7ac:
	bl.d L_8f972c
L_8fb7b0:
	mov_s r3,r15
L_8fb7b2:
	brne r0,0x1,L_8fb7ba
L_8fb7b6:
	stb_s r15,[r13]
L_8fb7b8:
	b_s L_8fb7be
	.global L_8fb7ba
L_8fb7ba:
	mov_s r0,0x1
L_8fb7bc:
	stb_s r0,[r13]
	.global L_8fb7be
L_8fb7be:
	mov_s r1,0x100e63c
L_8fb7c4:
	mov_s r0,0x2b
L_8fb7c6:
	bl.d L_8dcc10
L_8fb7ca:
	ldb_s r2,[r14,0x7]
L_8fb7cc:
	mov_s r0,r13
L_8fb7ce:
	mov_s r1,0x1911
L_8fb7d4:
	mov_s r2,0x4
L_8fb7d6:
	ldb_s r3,[r14,0x7]
L_8fb7d8:
	mov r4,0x0
L_8fb7dc:
	mov r5,r4
L_8fb7e0:
	bl.d L_8e5474
L_8fb7e4:
	mov r6,r4
L_8fb7e8:
	b L_8c024c
	.global L_8fb7ec
L_8fb7ec:
	mov_s r1,0x100e67c
L_8fb7f2:
	bl.d L_8dcba8
L_8fb7f6:
	mov_s r0,0x1b
L_8fb7f8:
	b_s L_8fb7ba
L_8fb7fa:
	nop_s
