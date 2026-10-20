/* tof_mgr__ftm_req_handle_8cb350 @ 0x8cb350, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] tof_mgr::ftm_req_handle() No tof sessions in the list
 * Зовут его: l2_mgr__tof_ftm_req
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, tof__find_session_by_addr, tof__next_request, tof_mgr__alloc_entry
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof_mgr__ftm_req_handle_8cb350
tof_mgr__ftm_req_handle_8cb350:
	.global L_8cb350
L_8cb350:
	push_s blink
L_8cb352:
	bl L_8c01e4
L_8cb356:
	mov_s r14,r0
L_8cb358:
	bl.d L_8e1df8
L_8cb35c:
	mov_s r13,r1
L_8cb35e:
	bl.d L_8e0b58
L_8cb362:
	mov_s r0,r14
L_8cb364:
	brne_s r0,0,L_8cb37a
L_8cb366:
	mov_s r1,0x1019830
L_8cb36c:
	bl.d L_8dcba8
L_8cb370:
	mov_s r0,0xb
L_8cb372:
	mov_s r0,r14
L_8cb374:
	bl.d L_8cb380
L_8cb378:
	ld_s r1,[r13]
	.global L_8cb37a
L_8cb37a:
	b L_8c0254
L_8cb37e:
	nop_s
