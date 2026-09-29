/* mlme_sm__association_done @ 0x8f1290, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [L2MGR] Ignore association_done_evt CID: %d (mid %d)>>> not connected
 *   [L2MGR] publish association_done_evt CID: %d (mid %d)
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, conn__alloc_and_link_kind1, dashboard__add_connection, fw_log_emit2, fw_status__set_state, l2mgr__program_assoc_vring, l2mgr__send_host_event, l2mgr__send_pbss_joined_evt, mid__type_of, sys_state__broadcast
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__association_done
mlme_sm__association_done:
	.global L_8f1290
L_8f1290:
	push_s blink
L_8f1292:
	bl L_8c01d8
L_8f1296:
	mov_s r14,r0
L_8f1298:
	ld_s r13,[r0,0x18]
L_8f129a:
	ld r0,[r0, 0xfc]
L_8f129e:
	ldb_s r2,[r14,0x8]
L_8f12a0:
	ldb_s r3,[r13,0x10]
L_8f12a2:
	brne_s r0,0,L_8f12b6
L_8f12a4:
	ld_s r0,[r14,0x28]
L_8f12a6:
	brne_s r0,0,L_8f12b6
L_8f12a8:
	mov_s r1,0x100d4b4
L_8f12ae:
	bl.d L_8dcc80
L_8f12b2:
	mov_s r0,0x2b
L_8f12b4:
	b_s L_8f1316
	.global L_8f12b6
L_8f12b6:
	mov_s r1,0x100d4fc
L_8f12bc:
	bl.d L_8dcc80
L_8f12c0:
	mov_s r0,0x2b
L_8f12c2:
	ldb r17,[r14, 0x8]
L_8f12c6:
	add r15,r14,0x1c
L_8f12ca:
	ld_s r0,[r14,0x18]
L_8f12cc:
	bl.d L_8ccecc
L_8f12d0:
	add r16,r0,0xa
L_8f12d4:
	mov_s r4,r0
L_8f12d6:
	mov_s r0,0x0
L_8f12d8:
	mov_s r1,r17
L_8f12da:
	mov_s r2,r15
L_8f12dc:
	mov_s r3,r16
L_8f12de:
	bl.d L_8db090
L_8f12e2:
	mov r5,0x1
L_8f12e6:
	ld_s r0,[r14,0x28]
L_8f12e8:
	breq_s r0,0,L_8f12f2
L_8f12ea:
	bl.d L_8f6dac
L_8f12ee:
	mov_s r0,r14
L_8f12f0:
	b_s L_8f12fa
	.global L_8f12f2
L_8f12f2:
	ldb_s r0,[r13,0x10]
L_8f12f4:
	bl.d L_8f86cc
L_8f12f8:
	ldb_s r1,[r14,0x8]
	.global L_8f12fa
L_8f12fa:
	mov_s r0,0x5
L_8f12fc:
	bl.d L_8e8a14
L_8f1300:
	ldb_s r1,[r14,0x8]
L_8f1302:
	mov_s r0,0x0
L_8f1304:
	bl.d L_8c733c
L_8f1308:
	ldb_s r1,[r13,0x10]
L_8f130a:
	bl.d L_8e8634
L_8f130e:
	mov_s r0,0x6
L_8f1310:
	bl.d L_8eabfc
L_8f1314:
	mov_s r0,r14
	.global L_8f1316
L_8f1316:
	b L_8c023c
L_8f131a:
	nop_s
