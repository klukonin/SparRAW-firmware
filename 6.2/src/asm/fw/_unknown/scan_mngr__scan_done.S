/* scan_mngr__scan_done @ 0x8f8220, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::scan_done()
 *   scan_mngr::scan_done() scan done notify host status = 0x%x <ts: %d> scan type:%d
 *   scan_mngr::scan_done() passive scan done notify host status = 0x%x <ts: %d> scan type:%d
 *   scan_mngr::scan_done() send command to uCode scan_mode = FALSE.
 * Зовут его: scan_mngr__dwelling_done, swc_psc_sm__action_complete_scan
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, discovery__rx_stop, fw_divmod_unsigned, fw_log_emit0, fw_log_emit3, l2_mgr__scan_complete_handle, l2mgr__send_scan_complete_evt, lmac_if_discovery_mode_cfg_handler, pcp_psc_sm__send_usol_psc_resp_sm, scan_mngr__clean_all_lists, scan_mngr__free_channel_list
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__scan_done
scan_mngr__scan_done:
	.global L_8f8220
L_8f8220:
	push_s blink
L_8f8222:
	bl L_8c01e0
L_8f8226:
	mov_s r14,r0
L_8f8228:
	mov_s r13,r1
L_8f822a:
	mov_s r1,0x10155a8
L_8f8230:
	bl.d L_8dcba8
L_8f8234:
	mov_s r0,0x29
L_8f8236:
	ld.as r0,[r14,0x89]
L_8f823a:
	cmp_s r0,0x0
L_8f823c:
	bl.ne.d L_8eaa88
L_8f8240:
	mov.ne r0,r14
L_8f8244:
	cmp_s r13,0x3
L_8f8246:
	bl.ne L_8f80ec
L_8f824a:
	mov_s r1,0x8054ec
L_8f8250:
	ldw_s r0,[r1,0x34]
L_8f8252:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f8254:
	extw_s r0,r0
L_8f8256:
	stw_s r0,[r1,0x34]
L_8f8258:
	bl.d L_8f3160
L_8f825c:
	mov_s r0,r14
L_8f825e:
	bl.d L_8f1aa0
L_8f8262:
	mov_s r0,r14
L_8f8264:
	ld.as r0,[r14,0x72]
L_8f8268:
	cmp_s r0,0x0
L_8f826a:
	ld_s r0,[r14,0x6c]
L_8f826c:
	mov.ne r13,0x2
L_8f8270:
	cmp_s r0,0x2
L_8f8272:
	mov_s r0,0x1
L_8f8274:
	sub_s.ne r0,r0,r0
L_8f8276:
	extb.f 0x0,r0
L_8f827a:
	bne_s L_8f82a0
L_8f827c:
	bl L_8e9524
L_8f8280:
	ld r4,[r14, 0x6c]
L_8f8284:
	mov_s r3,r0
L_8f8286:
	mov_s r1,0x10155c0
L_8f828c:
	mov_s r0,0x29
L_8f828e:
	bl.d L_8dcd00
L_8f8292:
	mov_s r2,r13
L_8f8294:
	ld_s r1,[r14,0x7c]
L_8f8296:
	mov_s r0,r13
L_8f8298:
	bl.d L_8e5d48
L_8f829c:
	ldb_s r1,[r1,0x10]
L_8f829e:
	b_s L_8f82d6
	.global L_8f82a0
L_8f82a0:
	bl L_8e9524
L_8f82a4:
	ld r4,[r14, 0x6c]
L_8f82a8:
	mov_s r3,r0
L_8f82aa:
	mov_s r1,0x1015614
L_8f82b0:
	mov_s r0,0x29
L_8f82b2:
	bl.d L_8dcd00
L_8f82b6:
	mov_s r2,r13
L_8f82b8:
	ld_s r15,[r14,0x7c]
L_8f82ba:
	ld_s r0,[r14,0x70]
L_8f82bc:
	bl.d L_8c02d4
L_8f82c0:
	mov r1,0x3e8
L_8f82c4:
	mov_s r2,r0
L_8f82c6:
	ldb_s r1,[r15,0x10]
L_8f82c8:
	extb_s r0,r13
L_8f82ca:
	add r4,r14,0x28
L_8f82ce:
	bl.d L_8e5a5c
L_8f82d2:
	ldb r3,[r14, 0x24]
	.global L_8f82d6
L_8f82d6:
	mov_s r13,0x0
L_8f82d8:
	st_s r13,[r14,0x78]
L_8f82da:
	mov_s r1,0x1015670
L_8f82e0:
	bl.d L_8dcba8
L_8f82e4:
	mov_s r0,0x29
L_8f82e6:
	ldb r1,[r14,0x217]
L_8f82ee:
	bl.d L_8db724
L_8f82f2:
	mov_s r0,r13
L_8f82f4:
	ld_s r0,[r14,0x7c]
L_8f82f6:
	ldb_s r0,[r0,0x10]
L_8f82f8:
	bl.d L_8e45fc
L_8f82fc:
	mov_s r1,0x1
L_8f82fe:
	b L_8c024c
L_8f8302:
	nop_s
