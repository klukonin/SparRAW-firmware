/* mgmt_tx__build_assoc_resp @ 0x8d8230, 328 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MGMT TX Assoc resp <<<<<<<<< PRIVACY %d >>>>>>>>>>>>> Capabilities length %d total %d
 *   ASSOC RESP internal & External IEs %d len
 *   ie_len %d
 *   ASSOC RESP internal IEs are built
 *   FIXED MGMT TX Assoc resp 60GHz Capability length %d total %d
 * Зовут его: handle_packet__args
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, app_ies__set_buffer, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, ie__push_wfa_vendor, ies_block__merge, memcpy_fw, mgmt_tx__assoc_resp_tlv, push_cap_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__build_assoc_resp
mgmt_tx__build_assoc_resp:
	.global L_8d8230
L_8d8230:
	sub_s sp,sp,0x4
L_8d8232:
	push_s blink
L_8d8234:
	bl L_8c01c8
L_8d8238:
	sub sp,sp,0x218
L_8d823c:
	st.as r0,[sp,0x90]
L_8d8240:
	mov_s r19,r1
L_8d8242:
	mov_s r14,r2
L_8d8244:
	mov_s r15,r3
L_8d8246:
	add3 r18,r1,0x9
L_8d824a:
	mov r17,sp
L_8d824e:
	mov_s r13,sp
L_8d8250:
	add r13,r13,0x200
L_8d8254:
	sub3 r16,r13,0x20
L_8d8258:
	bl.d L_8e1d78
L_8d825c:
	add2 r1,r18,0x17
L_8d8260:
	ld.as r1,[sp,0x90]
L_8d8264:
	extb_s r3,r0
L_8d8266:
	add_s r1,r1,r3
L_8d8268:
	st.as r1,[sp,0x90]
L_8d826c:
	extb r21,r0
L_8d8270:
	add_s r14,r14,r3
L_8d8272:
	sub_s r15,r15,r3
L_8d8274:
	extw_s r15,r15
L_8d8276:
	ld r2,[r19, 0x3c]
L_8d827a:
	mov_s r1,0x101002c
L_8d8280:
	mov_s r0,0x2d
L_8d8282:
	bl.d L_8dcd00
L_8d8286:
	mov r4,r21
L_8d828a:
	ld.as r0,[sp,0x90]
L_8d828e:
	mov_s r1,r14
L_8d8290:
	bl.d L_8c0380
L_8d8294:
	mov_s r2,0x4
L_8d8296:
	ld.as r1,[sp,0x90]
L_8d829a:
	ldw r20,[r14, 0x2]
L_8d829e:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_8d82a0:
	st.as r1,[sp,0x90]
L_8d82a4:
	add r21,r21,0x4
L_8d82a8:
	/* sub_s r15,r15,0x4 */
	.byte 0x64,0xbf
L_8d82aa:
	extw_s r15,r15
L_8d82ac:
	extw r21,r21
L_8d82b0:
	brlt.d r15,0x1,L_8d8316
L_8d82b4:
	add_s r1,r14,0x4
L_8d82b6:
	sub3 r0,r13,0x20
L_8d82ba:
	bl.d L_8c0380
L_8d82be:
	mov_s r2,r15
L_8d82c0:
	mov_s r0,r17
L_8d82c2:
	mov_s r1,r18
L_8d82c4:
	bl.d L_8f4fa0
L_8d82c8:
	mov_s r2,r20
L_8d82ca:
	mov_s r18,r0
L_8d82cc:
	mov_s r1,0x1010084
L_8d82d2:
	mov_s r0,0x2d
L_8d82d4:
	bl.d L_8dcc10
L_8d82d8:
	mov_s r2,r18
L_8d82da:
	mov_s r0,r13
L_8d82dc:
	mov_s r1,r17
L_8d82de:
	mov_s r2,r18
L_8d82e0:
	bl.d L_8e693c
L_8d82e4:
	mov_s r3,0x0
L_8d82e6:
	add r0,r13,0xc
L_8d82ea:
	mov_s r1,r16
L_8d82ec:
	mov_s r2,r15
L_8d82ee:
	bl.d L_8e693c
L_8d82f2:
	mov_s r3,0x0
L_8d82f4:
	mov_s r0,sp
L_8d82f6:
	add r0,r0,0x240
L_8d82fa:
	add r1,r13,0xc
L_8d82fe:
	bl.d L_8ddfd0
L_8d8302:
	mov_s r2,r13
L_8d8304:
	extb_s r13,r0
L_8d8306:
	mov_s r1,0x10100b0
L_8d830c:
	mov_s r0,0x2d
L_8d830e:
	bl.d L_8dcc10
L_8d8312:
	mov_s r2,r13
L_8d8314:
	b_s L_8d833a
	.global L_8d8316
L_8d8316:
	mov_s r1,0x10100bc
L_8d831c:
	bl.d L_8dcba8
L_8d8320:
	mov_s r0,0x2d
L_8d8322:
	ld.as r0,[sp,0x90]
L_8d8326:
	mov_s r1,r18
L_8d8328:
	bl.d L_8f4fa0
L_8d832c:
	mov_s r2,r20
L_8d832e:
	extb_s r13,r0
L_8d8330:
	ld.as r0,[sp,0x90]
L_8d8334:
	add_s r0,r0,r13
L_8d8336:
	st.as r0,[sp,0x90]
	.global L_8d833a
L_8d833a:
	add_s r13,r13,r21
L_8d833c:
	add r1,r19,0xa
L_8d8340:
	ld.as r0,[sp,0x90]
L_8d8344:
	bl.d L_8e1c94
L_8d8348:
	mov_s r2,0x0
L_8d834a:
	extb_s r2,r0
L_8d834c:
	ld.as r0,[sp,0x90]
L_8d8350:
	extw_s r13,r13
L_8d8352:
	add_s r0,r0,r2
L_8d8354:
	st.as r0,[sp,0x90]
L_8d8358:
	add_s r13,r13,r2
L_8d835a:
	extw_s r13,r13
L_8d835c:
	mov_s r1,0x10100e0
L_8d8362:
	mov_s r0,0x2d
L_8d8364:
	bl.d L_8dcc80
L_8d8368:
	mov_s r3,r13
L_8d836a:
	mov_s r0,r13
L_8d836c:
	mov_s r12,0x8
L_8d836e:
	b.d L_8c021e
L_8d8372:
	add sp,sp,0x218
L_8d8376:
	nop_s
