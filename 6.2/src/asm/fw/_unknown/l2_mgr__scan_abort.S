/* l2_mgr__scan_abort @ 0x8e4588, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::scan_abort: scan is not active. Sending done event
 *   l2_mgr::scan_abort: Sending scan stop to MID:[%d]
 *   l2_mgr::scan_abort: P2P Find session stop to MID:[%d]
 * Зовут его: low_sme__handle_rf_kill
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit1, mid_list__by_mid_fw, scan_abort, stop_find_session, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__scan_abort
l2_mgr__scan_abort:
	.global L_8e4588
L_8e4588:
	push_s blink
L_8e458a:
	bl L_8c01e4
L_8e458e:
	mov_s r14,0x0
L_8e4590:
	b_s L_8e45b0
	.global L_8e4592
L_8e4592:
	mov_s r1,0x100e550
L_8e4598:
	bl.d L_8dcba8
L_8e459c:
	mov_s r0,0x2b
L_8e459e:
	mov_s r0,0x2d9c4
L_8e45a4:
	mov_s r1,0x0
L_8e45a6:
	mov_s r2,r1
L_8e45a8:
	bl.d L_8c3248
L_8e45ac:
	mov_s r3,0x1
	.global L_8e45ae
L_8e45ae:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8e45b0
L_8e45b0:
	brge r14,0x1,L_8e45f8
L_8e45b4:
	bl.d L_8cc3dc
L_8e45b8:
	mov_s r0,r14
L_8e45ba:
	breq_s r0,0,L_8e45ae
L_8e45bc:
	mov_s r13,r0
L_8e45be:
	add r13,r13,0x234
L_8e45c2:
	ld_s r0,[r13,0x8]
L_8e45c4:
	ld_s r0,[r0,0x78]
L_8e45c6:
	breq_s r0,0,L_8e45de
L_8e45c8:
	mov_s r1,0x100e58c
L_8e45ce:
	mov_s r0,0x2b
L_8e45d0:
	bl.d L_8dcc10
L_8e45d4:
	mov_s r2,r14
L_8e45d6:
	bl.d L_8f81fc
L_8e45da:
	mov_s r0,r13
L_8e45dc:
	b_s L_8e45ae
	.global L_8e45de
L_8e45de:
	ld_s r0,[r13,0x4c]
L_8e45e0:
	breq_s r0,0,L_8e4592
L_8e45e2:
	mov_s r1,0x100e5c0
L_8e45e8:
	mov_s r0,0x2b
L_8e45ea:
	bl.d L_8dcc10
L_8e45ee:
	mov_s r2,r14
L_8e45f0:
	bl.d L_8f9b48
L_8e45f4:
	mov_s r0,r13
L_8e45f6:
	b_s L_8e45ae
	.global L_8e45f8
L_8e45f8:
	b L_8c0254
