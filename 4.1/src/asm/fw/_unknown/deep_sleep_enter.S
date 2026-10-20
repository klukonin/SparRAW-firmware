/* deep_sleep_enter @ 0x8c71b8, 540 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   deep_sleep_enter: Send MAILBOX is not empty!!!
 *   deep_sleep_enter: Send MAILBOX empty Delay - Start!!!
 *   deep_sleep_enter: Send MAILBOX empty Delay - End!!!
 *   POWER_MNGR::deep_sleep_enter - PERST ASSERTED
 *   deep_sleep_enter: time to next scheduling event = %d usec
 *   deep_sleep_enter: No L1 exit interrupt When: LTSSM State 0x%x, L1SS state: 0x%x, AUX_CLK_IS_SYS_CLK: %d
 * Зовут его: u_schd__large_task_warn
 * Зовёт сам: POWER_MNGR__halt, __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit3, get_g_80035c, get_reg882fd4_s19_w32, get_reg88b0c0_s2_w32, get_reg_8802bc, hwd_pcie__get_882b80, hwd_pcie__get_ltssm_state
 * Глобалы (через gp): 0x800408, 0x800468, 0x80046c
 */
	.section .text.deep_sleep_enter,"ax",@progbits
	.global deep_sleep_enter
deep_sleep_enter:
	.global L_8c71b8
L_8c71b8:
	push_s blink
L_8c71ba:
	bl L_8c02b4
L_8c71be:
	bl.d L_8ca008
L_8c71c2:
	sub_s sp,sp,0x10
L_8c71c4:
	mov_s r14,r0
L_8c71c6:
	ld_s r0,[gp,-0x58]
L_8c71c8:
	ld_s r1,[r0,0x8]
L_8c71ca:
	ld_s r1,[r1,0x28]
L_8c71cc:
	jl_s [r1]
L_8c71ce:
	mov_s r13,r0
L_8c71d0:
	ld_s r0,[gp,-0x58]
L_8c71d2:
	ld_s r1,[r0,0x8]
L_8c71d4:
	ld_s r1,[r1,0x18]
L_8c71d6:
	jl_s [r1]
L_8c71d8:
	breq_s r0,0,L_8c71e2
L_8c71da:
	bl L_8ce918
L_8c71de:
	b L_8c73cc
	.global L_8c71e2
L_8c71e2:
	ld_s r0,[gp,-0x58]
L_8c71e4:
	ld_s r1,[r0,0x8]
L_8c71e6:
	ld_s r1,[r1,0x14]
L_8c71e8:
	jl_s [r1]
L_8c71ea:
	breq_s r0,0,L_8c71ee
L_8c71ec:
	breq_s r13,0,L_8c71fa
	.global L_8c71ee
L_8c71ee:
	mov_s r0,0x0
L_8c71f0:
	st.as r0,[gp,-0xa]
L_8c71f4:
	st.as r0,[gp,-0xb]
L_8c71f8:
	b_s L_8c73cc
	.global L_8c71fa
L_8c71fa:
	ld_s r0,[r14]
L_8c71fc:
	bbit1 r0,0xc,L_8c7270
L_8c7200:
	bl L_8d752c
L_8c7204:
	ld.as r1,[gp,-0xa]
L_8c7208:
	breq_s r0,0,L_8c7230
L_8c720a:
	mov_s r0,0x0
L_8c720c:
	st.as r0,[gp,-0xb]
L_8c7210:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c7212:
	st.as r1,[gp,-0xa]
L_8c7216:
	mov_s r2,0x1001f28
L_8c721c:
	mov_s r0,0xe
L_8c721e:
	bl.d L_8edfb0
L_8c7222:
	mov_s r1,0x2
L_8c7224:
	ld_s r0,[gp,-0x28]
L_8c7226:
	ld.as r1,[gp,0xbf]
L_8c722a:
	brhs r0,r1,L_8c7270
L_8c722e:
	b_s L_8c73cc
	.global L_8c7230
L_8c7230:
	ld_s r0,[gp,-0x2c]
L_8c7232:
	cmp_s r1,0x0
L_8c7234:
	cmp.eq r0,0x0
L_8c7238:
	beq_s L_8c7270
L_8c723a:
	brne_s r0,0,L_8c724a
L_8c723c:
	mov_s r2,0x1001f58
L_8c7242:
	mov_s r0,0xe
L_8c7244:
	bl.d L_8edfb0
L_8c7248:
	mov_s r1,0x2
	.global L_8c724a
L_8c724a:
	mov_s r0,0x0
L_8c724c:
	st.as r0,[gp,-0xa]
L_8c7250:
	ld_s r0,[gp,-0x2c]
L_8c7252:
	ld.as r1,[gp,0xbe]
L_8c7256:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c7258:
	cmp_s r0,r1
L_8c725a:
	bcs.d L_8c73cc
L_8c725e:
	st.as r0,[gp,-0xb]
L_8c7262:
	mov_s r2,0x1001f90
L_8c7268:
	mov_s r0,0xe
L_8c726a:
	bl.d L_8edfb0
L_8c726e:
	mov_s r1,0x2
	.global L_8c7270
L_8c7270:
	mov_s r13,0x0
L_8c7272:
	ld_s r0,[r14]
L_8c7274:
	st.as r13,[gp,-0xb]
L_8c7278:
	btst_s r0,0xc
L_8c727a:
	st.as r13,[gp,-0xa]
L_8c727e:
	mov.eq r15,r13
L_8c7282:
	beq_s L_8c72d4
L_8c7284:
	ld_s r0,[gp,-0x58]
L_8c7286:
	ld_s r2,[r0,0x8]
L_8c7288:
	ld_s r2,[r2,0x24]
L_8c728a:
	jl_s.d [r2]
L_8c728c:
	mov_s r1,sp
L_8c728e:
	add_s r1,sp,0x8
L_8c7290:
	mov_s r0,r13
L_8c7292:
	bl.d L_8e4840
L_8c7296:
	mov_s r2,r13
L_8c7298:
	ld_s r0,[sp,0x8]
L_8c729a:
	ld_s r2,[sp,0x0]
L_8c729c:
	sub.f r3,r0,r2
L_8c72a0:
	ld_s r15,[sp,0xc]
L_8c72a2:
	ld_s r1,[sp,0x4]
L_8c72a4:
	sbc r15,r15,r1
L_8c72a8:
	cmp_s r15,0x80000000
L_8c72ae:
	cmp.eq r3,0x0
L_8c72b2:
	bcs L_8c73cc
L_8c72b6:
	sub r15,r2,r0
L_8c72ba:
	ld_s r0,[gp,-0x68]
L_8c72bc:
	ldw_s r3,[r0]
L_8c72be:
	ld_s r0,[gp,0x298]
L_8c72c0:
	add_s r3,r3,r0
L_8c72c2:
	cmp_s r15,r3
L_8c72c4:
	bcs L_8c73cc
L_8c72c8:
	sub.f r2,r2,r0
L_8c72cc:
	sbc r1,r1,r13
L_8c72d0:
	st_s r2,[sp,0x0]
L_8c72d2:
	st_s r1,[sp,0x4]
	.global L_8c72d4
L_8c72d4:
	lr r16,[0xa]
L_8c72d8:
	bic r0,r16,0x6
L_8c72dc:
	flag r0
L_8c72e0:
	bl L_8ce344
L_8c72e4:
	brne r0,0x1,L_8c73be
L_8c72e8:
	ld_s r0,[r14,0x4]
L_8c72ea:
	bbit0 r0,0x2,L_8c72fa
L_8c72ee:
	ld_s r0,[r14]
L_8c72f0:
	btst_s r0,0x5
L_8c72f2:
	bl.ne.d L_8d4d20
L_8c72f6:
	mov.ne r0,0x1
	.global L_8c72fa
L_8c72fa:
	bl L_8ce8ac
L_8c72fe:
	bl L_8ce918
L_8c7302:
	ld_s r1,[r14]
L_8c7304:
	bbit0 r1,0xc,L_8c731e
L_8c7308:
	ld_s r0,[gp,-0x9c]
L_8c730a:
	cmp_s r0,0x0
L_8c730c:
	btst.ne r1,0x8
L_8c7310:
	bne_s L_8c731e
L_8c7312:
	ld_s r0,[sp,0x0]
L_8c7314:
	bl.d L_8e498c
L_8c7318:
	ld_s r1,[sp,0x4]
L_8c731a:
	bl L_8e49bc
	.global L_8c731e
L_8c731e:
	mov_s r13,0x803590
L_8c7324:
	ld_s r0,[r13,0x24]
L_8c7326:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c7328:
	bl.d L_8ce6f0
L_8c732c:
	st_s r0,[r13,0x24]
L_8c732e:
	brne r0,0x5,L_8c7338
L_8c7332:
	ld_s r0,[r13,0x28]
L_8c7334:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c7336:
	st_s r0,[r13,0x28]
	.global L_8c7338
L_8c7338:
	bl L_8ce72c
L_8c733c:
	brne_s r0,0,L_8c7352
L_8c733e:
	ld_s r0,[r13,0x2c]
L_8c7340:
	mov_s r2,0x1001fc4
L_8c7346:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c7348:
	st_s r0,[r13,0x2c]
L_8c734a:
	mov_s r0,0xe
L_8c734c:
	bl.d L_8edfb0
L_8c7350:
	mov_s r1,0x2
	.global L_8c7352
L_8c7352:
	ld_s r0,[r14]
L_8c7354:
	bbit0 r0,0xc,L_8c736c
L_8c7358:
	ld_s r0,[gp,0x298]
L_8c735a:
	mov_s r2,0x1001ff4
L_8c7360:
	sub r3,r15,r0
L_8c7364:
	mov_s r0,0xe
L_8c7366:
	bl.d L_8edfcc
L_8c736a:
	mov_s r1,0x2
	.global L_8c736c
L_8c736c:
	ld_s r0,[r14]
L_8c736e:
	ld_s r1,[sp,0x0]
L_8c7370:
	lsr_s r0,r0,0xb
L_8c7372:
	bmsk_s r0,r0,0x0
L_8c7374:
	bl.d L_8c73d4
L_8c7378:
	ld_s r2,[sp,0x4]
L_8c737a:
	bl L_8ce32c
L_8c737e:
	brne_s r0,0,L_8c73be
L_8c7380:
	bl L_8ce72c
L_8c7384:
	brne r0,0x1,L_8c73be
L_8c7388:
	bl L_8ce948
L_8c738c:
	brne_s r0,0,L_8c73ba
L_8c738e:
	bl L_8ce700
L_8c7392:
	bl.d L_8ce6f0
L_8c7396:
	mov_s r18,r0
L_8c7398:
	bl.d L_8ce32c
L_8c739c:
	mov_s r17,r0
L_8c739e:
	mov_s r5,r0
L_8c73a0:
	mov_s r2,0x1002030
L_8c73a6:
	mov_s r0,0xe
L_8c73a8:
	mov_s r1,0x0
L_8c73aa:
	mov_s r3,r18
L_8c73ac:
	bl.d L_8ee034
L_8c73b0:
	mov r4,r17
L_8c73b4:
	ld_s r0,[r13,0x34]
L_8c73b6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c73b8:
	st_s r0,[r13,0x34]
	.global L_8c73ba
L_8c73ba:
	bl L_8ce928
	.global L_8c73be
L_8c73be:
	lr r0,[0xa]
L_8c73c2:
	and r1,r16,0x6
L_8c73c6:
	or_s r0,r0,r1
L_8c73c8:
	flag r0
	.global L_8c73cc
L_8c73cc:
	b.d L_8c0314
L_8c73d0:
	add_s sp,sp,0x10
L_8c73d2:
	nop_s
