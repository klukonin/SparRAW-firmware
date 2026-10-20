/* l2_mgr__connect_multi_omni @ 0x8c71fc, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::connect_multi_omni() we don't know this ap
 *   l2_mgr::connect_multi_omni() curr_systime = %d add pending_event in %d usec. We need omni %d
 *   l2_mgr::connect_multi_omni() bcon_systime  %d
 * Зовут его: wmi_connect
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_divmod_unsigned, fw_log_emit0, fw_log_emit1, fw_log_emit3, l2_mgr__connect_multi_omni_cb, l2_mgr__connect_next, mid_list__by_mid_fw, u_schd__now, u_schd__schedule
 * Глобалы (через gp): 0x800338
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__connect_multi_omni
l2_mgr__connect_multi_omni:
	.global L_8c71fc
L_8c71fc:
	push_s blink
L_8c71fe:
	bl L_8c01cc
L_8c7202:
	mov_s r15,r0
L_8c7204:
	mov_s r20,r1
L_8c7206:
	bl.d L_8cc3dc
L_8c720a:
	mov_s r0,r1
L_8c720c:
	mov_s r16,r0
L_8c720e:
	ld.as r0,[r0,0x8f]
L_8c7212:
	add r1,r15,0x34
L_8c7216:
	bl.d L_8e4c24
L_8c721a:
	ldb r2,[r15, 0x28]
L_8c721e:
	st.as r0,[gp,0x6d]
L_8c7222:
	brne_s r0,0,L_8c723a
L_8c7224:
	mov_s r1,0x100ea60
L_8c722a:
	bl.d L_8dcba8
L_8c722e:
	mov_s r0,0x1b
L_8c7230:
	mov_s r0,r15
L_8c7232:
	bl.d L_8c7300
L_8c7236:
	mov_s r1,r20
L_8c7238:
	b_s L_8c72fc
	.global L_8c723a
L_8c723a:
	bl.d L_8e9524
L_8c723e:
	ld_s r14,[r0,0x10]
L_8c7240:
	ld.as r19,[gp,0x6d]
L_8c7244:
	mov_s r13,r0
L_8c7246:
	ldw r0,[r19, 0xa]
L_8c724a:
	ldb r1,[gp, 0xad]
L_8c724e:
	mul64 r0,0x3e8
L_8c7252:
	add r17,mlo,0x960
L_8c725a:
	mulu64 r1,r17
L_8c725e:
	brlo.d r13,r14,L_8c726e
L_8c7262:
	mov r18,mlo
L_8c7266:
	sub r0,r13,r14
L_8c726a:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c726c:
	b_s L_8c727c
	.global L_8c726e
L_8c726e:
	rsub r0,r14,0xffffffff
L_8c7276:
	add_s r0,r0,r13
L_8c7278:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c727a:
	add_s r0,r0,0x10
	.global L_8c727c
L_8c727c:
	bl.d L_8c02d4
L_8c7280:
	mov_s r1,r18
L_8c7282:
	mov_s r1,r18
L_8c7284:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c7286:
	mulu64 r0,r1
L_8c728a:
	lsr r1,mlo,0x4
L_8c728e:
	add_s r1,r1,r14
L_8c7290:
	cmp_s r13,r1
L_8c7292:
	sub.ls r1,r1,r13
L_8c7296:
	asl.ls r1,r1,0x4
L_8c729a:
	bls_s L_8c72aa
L_8c729c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c729e:
	rsub r0,r13,0xffffffff
L_8c72a6:
	add_s r0,r0,r1
L_8c72a8:
	asl_s r1,r0,0x4
	.global L_8c72aa
L_8c72aa:
	add r0,r1,r18
L_8c72ae:
	cmp r17,r1
L_8c72b2:
	mov.cs r0,r1
L_8c72b6:
	sub r18,r0,r17
L_8c72ba:
	mov_s r1,0x100ea94
L_8c72c0:
	ldb r4,[r19, 0x6]
L_8c72c4:
	mov_s r0,0x2b
L_8c72c6:
	mov_s r2,r13
L_8c72c8:
	bl.d L_8dcd00
L_8c72cc:
	mov_s r3,r18
L_8c72ce:
	mov_s r1,0x100eaf4
L_8c72d4:
	mov_s r0,0x29
L_8c72d6:
	bl.d L_8dcc10
L_8c72da:
	mov_s r2,r14
L_8c72dc:
	mov_s r0,0x7300
L_8c72e2:
	mov_s r1,r15
L_8c72e4:
	mov_s r2,r20
L_8c72e6:
	mov_s r3,0x1
L_8c72e8:
	mov r4,r18
L_8c72ec:
	mov r5,0x0
L_8c72f0:
	bl.d L_8e0c0c
L_8c72f4:
	mov r6,r5
L_8c72f8:
	st.as r0,[r16,0xab]
	.global L_8c72fc
L_8c72fc:
	b L_8c0224
