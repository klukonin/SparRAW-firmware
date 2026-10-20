/* host_if__timestamp_sync @ 0x8d967c, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HOST TIMESTAMP SYNC %02d/%02d/%04d
 *                       %02d:%02d:%02d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, conn_mgr__by_cid, fill_statistics_to_host, fw_log__emit3, host_if__arm_ts_sync_timer
 * Глобалы (через gp): 0x800234
 */
	.section .text.host_if__timestamp_sync,"ax",@progbits
	.global host_if__timestamp_sync
host_if__timestamp_sync:
	.global L_8d967c
L_8d967c:
	push_s blink
L_8d967e:
	bl L_8c02bc
L_8d9682:
	mov_s r16,r0
L_8d9684:
	ldb_s r0,[gp,0xc4]
L_8d9686:
	mov_s r14,r1
L_8d9688:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d968a:
	extb_s r0,r0
L_8d968c:
	stb r0,[gp, 0xc4]
L_8d9690:
	brne r0,0x3c,L_8d96ce
L_8d9694:
	mov_s r13,0x0
L_8d9696:
	stb r13,[gp, 0xc4]
L_8d969a:
	mov_s r2,0x1006134
L_8d96a0:
	ldb_s r15,[r14,0x1]
L_8d96a2:
	ldb r4,[r14, 0x2]
L_8d96a6:
	mov_s r5,r15
L_8d96a8:
	add r5,r5,0x700
L_8d96ac:
	mov_s r0,r13
L_8d96ae:
	mov_s r1,0x2
L_8d96b0:
	bl.d L_8ee034
L_8d96b4:
	ldb_s r3,[r14,0x3]
L_8d96b6:
	mov_s r2,0x1006158
L_8d96bc:
	ldb r4,[r14, 0x9]
L_8d96c0:
	mov_s r0,r13
L_8d96c2:
	ldb r5,[r14, 0xa]
L_8d96c6:
	mov_s r1,0x2
L_8d96c8:
	bl.d L_8ee034
L_8d96cc:
	ldb_s r3,[r14,0x8]
	.global L_8d96ce
L_8d96ce:
	bl.d L_8c9e44
L_8d96d2:
	ldb_s r0,[r14]
L_8d96d4:
	breq_s r0,0,L_8d9712
L_8d96d6:
	ld_s r1,[r14,0x4]
L_8d96d8:
	add2 r13,r0,0x19
L_8d96dc:
	brne_s r1,0,L_8d970a
L_8d96de:
	bl.d L_8c2c38
L_8d96e2:
	mov_s r0,r16
L_8d96e4:
	mov_s r14,r0
L_8d96e6:
	mov_s r0,r13
L_8d96e8:
	bl.d L_8c88d4
L_8d96ec:
	mov_s r1,r14
L_8d96ee:
	mov_s r0,r16
L_8d96f0:
	mov_s r1,r14
L_8d96f2:
	mov_s r2,0x0
L_8d96f4:
	mov_s r3,0x1863
L_8d96fa:
	mov r4,0x2c
L_8d96fe:
	mov_s r5,r2
L_8d9700:
	mov_s r6,r2
L_8d9702:
	bl.d L_8e0460
L_8d9706:
	mov_s r7,r2
L_8d9708:
	b_s L_8d9712
	.global L_8d970a
L_8d970a:
	mov_s r0,r13
L_8d970c:
	bl.d L_8dc824
L_8d9710:
	mov_s r2,0x0
	.global L_8d9712
L_8d9712:
	b L_8c0324
L_8d9716:
	nop_s
