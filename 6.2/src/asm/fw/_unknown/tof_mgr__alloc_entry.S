/* tof_mgr__alloc_entry @ 0x8cb380, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tof_mgr, tof_mgr__ftm_error_handler, tof_mgr__ftm_req_done, tof_mgr__ftm_req_handle, tof_mgr__ftm_req_handle_8cb350
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, host_if__send_pair, low_sme__send_evt2sw, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof_mgr__alloc_entry
tof_mgr__alloc_entry:
	.global L_8cb380
L_8cb380:
	push_s blink
L_8cb382:
	bl L_8c01e4
L_8cb386:
	sub_s sp,sp,0x8
L_8cb388:
	bl.d L_8c32d8
L_8cb38c:
	mov_s r14,r1
L_8cb38e:
	mov_s r13,r0
L_8cb390:
	st_s r14,[r0]
L_8cb392:
	mov_s r14,0x0
L_8cb394:
	stb_s r14,[r0,0x4]
L_8cb396:
	mov_s r1,sp
L_8cb398:
	mov_s r0,r14
L_8cb39a:
	bl.d L_8e9900
L_8cb39e:
	mov_s r2,r14
L_8cb3a0:
	mov_s r0,r13
L_8cb3a2:
	mov_s r1,0x1991
L_8cb3a8:
	mov_s r2,0x8
L_8cb3aa:
	mov_s r3,r14
L_8cb3ac:
	mov_s r4,r14
L_8cb3ae:
	mov_s r5,r14
L_8cb3b0:
	bl.d L_8e5474
L_8cb3b4:
	mov_s r6,r14
L_8cb3b6:
	b.d L_8c0254
L_8cb3ba:
	add_s sp,sp,0x8
