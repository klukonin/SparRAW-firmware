/* STREAM_MGR__ready_for_modify @ 0x8e2348, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp_service__radio_locked_cb
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, temp__get_active_rf, temp_sense__no_rf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global STREAM_MGR__ready_for_modify
STREAM_MGR__ready_for_modify:
	.global L_8e2348
L_8e2348:
	push_s blink
L_8e234a:
	bl L_8c01dc
L_8e234e:
	mov_s r13,0x0
L_8e2350:
	mov_s r15,0x853800
L_8e2356:
	add r16,r15,0x10
L_8e235a:
	mov_s r14,0x8
	.global L_8e235c
L_8e235c:
	ld.as r2,[gp,-0x57]
L_8e2360:
	mov_s r0,0x8042c8
L_8e2366:
	mov_s r1,r13
L_8e2368:
	bl.d L_8e221c
L_8e236c:
	ld.as r3,[gp,-0x56]
L_8e2370:
	mov_s r1,0x847fa8
L_8e2376:
	add2_s r1,r1,r13
L_8e2378:
	st_s r0,[r1]
L_8e237a:
	add2 r12,r16,r13
L_8e237e:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8e2380:
	st_s r0,[r12]
L_8e2382:
	brhs.d r14,0x1,L_8e235c
L_8e2386:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e2388:
	mov_s r13,0x0
L_8e238a:
	bl.d L_8ccbf4
L_8e238e:
	mov_s r0,r13
L_8e2390:
	st_s r0,[r15,0xc]
L_8e2392:
	ld_s r0,[gp,-0x15c]
L_8e2394:
	breq_s r0,0,L_8e23a0
L_8e2396:
	ld_s r0,[gp,-0x158]
L_8e2398:
	brne r0,0x3,L_8e23a0
L_8e239c:
	st.as r13,[gp,-0x57]
	.global L_8e23a0
L_8e23a0:
	b L_8c0244
