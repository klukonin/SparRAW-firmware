/* tof_mgr__ftm_error_handler @ 0x8cb210, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tof_mgr::ftm_error_handler()
 * Зовут его: ftm_main_sm__action_abort_session, state_sm_8034c0__action_step
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, discovery__rx_stop, fw_log_emit0, host_if__send_pair, low_sme__send_evt2sw, memcpy_fw, radio_mgr__call_method_10, tof__next_request, tof_mgr__alloc_entry
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof_mgr__ftm_error_handler
tof_mgr__ftm_error_handler:
	.global L_8cb210
L_8cb210:
	push_s blink
L_8cb212:
	bl L_8c01d8
L_8cb216:
	mov_s r17,r0
L_8cb218:
	mov_s r1,0x1019acc
L_8cb21e:
	bl.d L_8dcba8
L_8cb222:
	mov_s r0,0x2b
L_8cb224:
	mov_s r14,0x806518
L_8cb22a:
	bl.d L_8ea800
L_8cb22e:
	ld_s r0,[r14,0x8]
L_8cb230:
	bl.d L_8f80ec
L_8cb234:
	mov_s r13,0x0
L_8cb236:
	ld_s r0,[r14,0x20]
L_8cb238:
	st_s r13,[r14,0x8]
L_8cb23a:
	ldb_s r15,[r0,0x1c]
L_8cb23c:
	bl.d L_8c32d8
L_8cb240:
	add r16,r0,0x10
L_8cb244:
	mov_s r14,r0
L_8cb246:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8cb248:
	mov_s r1,r16
L_8cb24a:
	bl.d L_8c0380
L_8cb24e:
	mov_s r2,0x6
L_8cb250:
	st_s r15,[r14]
L_8cb252:
	mov_s r0,0x1
L_8cb254:
	stb_s r0,[r14,0xa]
L_8cb256:
	stb_s r0,[r14,0xb]
L_8cb258:
	mov_s r0,r14
L_8cb25a:
	mov_s r1,0x1995
L_8cb260:
	mov_s r2,0x20
L_8cb262:
	mov_s r3,r13
L_8cb264:
	mov_s r4,r13
L_8cb266:
	mov_s r5,r13
L_8cb268:
	bl.d L_8e5474
L_8cb26c:
	mov_s r6,r13
L_8cb26e:
	bl.d L_8e0b58
L_8cb272:
	mov_s r0,r17
L_8cb274:
	cmp_s r0,0x0
L_8cb276:
	mov.eq r0,r17
L_8cb27a:
	bl.eq.d L_8cb380
L_8cb27e:
	mov.eq r1,r15
L_8cb282:
	b L_8c023c
L_8cb286:
	nop_s
