/* scan_mngr__prob_resp_timeout_cb @ 0x8f7670, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::prob_resp_timeout_cb() me=0x%X p_dband_info=0x%X
 *   [NNL]-- scan_mngr=%d  prob_resp_timeout_event_id=%d
 *   scan_mngr::prob_resp_timeout_cb() to:  ADDR-%04X%08X
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, fw_sysassert_fatal, scan_mngr__prob_done
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__prob_resp_timeout_cb
scan_mngr__prob_resp_timeout_cb:
	.global L_8f7670
L_8f7670:
	push_s blink
L_8f7672:
	bl L_8c01dc
L_8f7676:
	mov_s r16,r0
L_8f7678:
	mov_s r14,r1
L_8f767a:
	mov_s r1,0x101649c
L_8f7680:
	mov_s r0,0x29
L_8f7682:
	mov_s r2,r16
L_8f7684:
	bl.d L_8dcc80
L_8f7688:
	mov_s r3,r14
L_8f768a:
	breq_s r14,0,L_8f76ca
	.global L_8f768c
L_8f768c:
	mov_s r13,r16
L_8f768e:
	add r13,r13,0x200
L_8f7692:
	ldb_s r2,[r13,0x15]
L_8f7694:
	mov_s r1,0x10164d8
L_8f769a:
	mov_s r0,0x29
L_8f769c:
	bl.d L_8dcc80
L_8f76a0:
	ld_s r3,[r14,0x48]
L_8f76a2:
	mov_s r0,0x0
L_8f76a4:
	st_s r0,[r14,0x48]
L_8f76a6:
	ldb_s r0,[r13,0x15]
L_8f76a8:
	mov_s r1,0x101650c
L_8f76ae:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8f76b0:
	stb_s r0,[r13,0x15]
L_8f76b2:
	ldw_s r2,[r14,0xc]
L_8f76b4:
	mov_s r0,0x29
L_8f76b6:
	bl.d L_8dcc80
L_8f76ba:
	ld_s r3,[r14,0x8]
L_8f76bc:
	mov_s r0,r16
L_8f76be:
	mov_s r1,0x3
L_8f76c0:
	bl.d L_8f74c4
L_8f76c4:
	mov_s r2,r14
L_8f76c6:
	b L_8c0244
	.global L_8f76ca
L_8f76ca:
	mov_s r0,blink
L_8f76cc:
	mov_s r1,0x51
L_8f76ce:
	/* bl.d 0x008c9b28 */
	.byte 0x5e,0x0c,0x2f,0xe9
L_8f76d2:
	/* _asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8f76d4:
	b_s L_8f768c
L_8f76d6:
	nop_s
