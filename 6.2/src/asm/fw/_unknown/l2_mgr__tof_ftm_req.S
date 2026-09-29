/* l2_mgr__tof_ftm_req @ 0x8e9620, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::tof_ftm_req: PARAMETERS DON'T MATCH CAPABILITY
 *   HOST EVENT (WMI_TOF_SESSION_END_EVENTID: session_id %d ,status %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, aoa__validate_request, fw_log_emit0, fw_log_emit2, host_if__send_pair, low_sme__send_evt2sw, tof_mgr__ftm_req_handle_8cb350
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__tof_ftm_req
l2_mgr__tof_ftm_req:
	.global L_8e9620
L_8e9620:
	push_s blink
L_8e9622:
	bl L_8c01e4
L_8e9626:
	bl.d L_8e9680
L_8e962a:
	mov_s r14,r0
L_8e962c:
	brne_s r0,0,L_8e9670
L_8e962e:
	bl L_8c32d8
L_8e9632:
	mov_s r13,r0
L_8e9634:
	ld_s r0,[r14]
L_8e9636:
	mov_s r1,0x100e8d8
L_8e963c:
	st_s r0,[r13]
L_8e963e:
	mov_s r0,0x2
L_8e9640:
	stb_s r0,[r13,0x4]
L_8e9642:
	bl.d L_8dcba8
L_8e9646:
	mov_s r0,0x2b
L_8e9648:
	ld_s r2,[r13]
L_8e964a:
	mov_s r1,0x100e910
L_8e9650:
	mov_s r0,0x2b
L_8e9652:
	bl.d L_8dcc80
L_8e9656:
	ldb_s r3,[r13,0x4]
L_8e9658:
	mov_s r0,r13
L_8e965a:
	mov_s r1,0x1991
L_8e9660:
	mov_s r2,0x8
L_8e9662:
	mov_s r3,0x0
L_8e9664:
	mov_s r4,r3
L_8e9666:
	mov_s r5,r3
L_8e9668:
	bl.d L_8e5474
L_8e966c:
	mov_s r6,r3
L_8e966e:
	b_s L_8e967c
	.global L_8e9670
L_8e9670:
	ld_s r0,[gp,-0x74]
L_8e9672:
	add r2,r14,0xc
L_8e9676:
	bl.d L_8cb350
L_8e967a:
	mov_s r1,r14
	.global L_8e967c
L_8e967c:
	b L_8c0254
