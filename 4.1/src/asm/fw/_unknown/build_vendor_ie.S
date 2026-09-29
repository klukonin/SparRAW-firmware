/* build_vendor_ie @ 0x8e2284, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__channel_locked_cb, l2mgr_mac_start_step, mid__log_network_type, mlme_sm__assoc_req_handle
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, vendor_ie__write_at_282
 */
	.section .text.build_vendor_ie,"ax",@progbits
	.global build_vendor_ie
build_vendor_ie:
	.global L_8e2284
L_8e2284:
	sub_s sp,sp,0x4
L_8e2286:
	push_s blink
L_8e2288:
	bl.d L_8c02bc
L_8e228c:
	mov r4,0x2
L_8e2290:
	sub_s sp,sp,0x8
L_8e2292:
	st_s r1,[sp,0x1c]
L_8e2294:
	mov_s r14,r0
L_8e2296:
	cmp_s r2,0x1
L_8e2298:
	mov_s r0,0x1
L_8e229a:
	sub_s.ne r0,r0,r0
L_8e229c:
	stw r0,[sp]
L_8e22a0:
	cmp_s r2,0x3
L_8e22a2:
	mov_s r0,0x1
L_8e22a4:
	sub_s.ne r0,r0,r0
L_8e22a6:
	stw r0,[sp, 0x2]
L_8e22aa:
	mov_s r0,0xdd
L_8e22ac:
	add3 r13,r14,0x20
L_8e22b0:
	stb_s r0,[r13,0x1a]
L_8e22b2:
	mov_s r0,0x4
L_8e22b4:
	stb_s r0,[r13,0x1c]
L_8e22b6:
	mov_s r0,0xce
L_8e22b8:
	stb_s r0,[r13,0x1d]
L_8e22ba:
	mov_s r0,0x14
L_8e22bc:
	stb_s r0,[r13,0x1e]
L_8e22be:
	mov_s r15,0x1
L_8e22c0:
	stw r15,[sp, 0x4]
L_8e22c4:
	add_s r3,sp,0x4
L_8e22c6:
	mov_s r0,r14
L_8e22c8:
	mov_s r1,0x5
L_8e22ca:
	bl.d L_8e7098
L_8e22ce:
	mov_s r2,r1
L_8e22d0:
	add r16,r0,0x5
L_8e22d4:
	extw r1,r16
L_8e22d8:
	mov_s r3,sp
L_8e22da:
	mov_s r0,r14
L_8e22dc:
	mov_s r2,r15
L_8e22de:
	bl.d L_8e7098
L_8e22e2:
	mov r4,0x2
L_8e22e6:
	add r15,r0,r16
L_8e22ea:
	extw_s r1,r15
L_8e22ec:
	add_s r3,sp,0x1c
L_8e22ee:
	mov_s r0,r14
L_8e22f0:
	mov_s r2,0x2
L_8e22f2:
	bl.d L_8e7098
L_8e22f6:
	mov r4,0x2
L_8e22fa:
	add_s r15,r15,r0
L_8e22fc:
	extw_s r1,r15
L_8e22fe:
	add r3,sp,0x2
L_8e2302:
	mov_s r0,r14
L_8e2304:
	mov_s r2,0x3
L_8e2306:
	bl.d L_8e7098
L_8e230a:
	mov r4,0x2
L_8e230e:
	add_s r15,r15,r0
L_8e2310:
	mov_s r0,0x880a7c
L_8e2316:
	ldw_s r0,[r0,0x10]
L_8e2318:
	extw_s r1,r15
L_8e231a:
	stw r0,[sp, 0x6]
L_8e231e:
	add r3,sp,0x6
L_8e2322:
	mov_s r0,r14
L_8e2324:
	mov_s r2,0x6
L_8e2326:
	bl.d L_8e7098
L_8e232a:
	mov r4,0x2
L_8e232e:
	add_s r0,r0,r15
L_8e2330:
	sub_s r1,r0,0x2
L_8e2332:
	extb_s r1,r1
L_8e2334:
	stb_s r1,[r13,0x1b]
L_8e2336:
	add r14,r14,0x17a
L_8e233a:
	stb_s r0,[r14]
L_8e233c:
	mov_s r12,0x8
L_8e233e:
	b.d L_8c0326
L_8e2342:
	add_s sp,sp,0x8
