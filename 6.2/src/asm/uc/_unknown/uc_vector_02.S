/* uc_vector_02 @ 0x9204bc, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Bad instruction (action point %X)
 *   Reason: ST/LD cmd before [ilink2=0x%X] (address being accessed is 0x%X)
 *   If the above address is not us - check [blink=0x%X]
 *   Bad instruction (unknown reason)
 *   regs%u: %08x %08x
 * Зовёт сам: __ld_r24_to_r13_ret, __st_r24_to_r13, uc_ap__read_match_value, uc_ap__read_triggered_mask, uc_log__emit1, uc_log__emit2, uc_log__emit3, uc_log__emit_snapshot, uc_sysassert, uc_sysassert__scan_stack
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_vector_02
uc_vector_02:
	.global L_9204bc
L_9204bc:
	push_s blink
L_9204be:
	bl L_92020c
L_9204c2:
	sub sp,sp,0x84
L_9204c6:
	st_s r0,[sp,0x4]
L_9204c8:
	st_s r1,[sp,0x8]
L_9204ca:
	st_s r2,[sp,0xc]
L_9204cc:
	st_s r3,[sp,0x10]
L_9204ce:
	st r4,[sp, 0x14]
L_9204d2:
	st r5,[sp, 0x18]
L_9204d6:
	st r6,[sp, 0x1c]
L_9204da:
	st r7,[sp, 0x20]
L_9204de:
	st r8,[sp, 0x24]
L_9204e2:
	st r9,[sp, 0x28]
L_9204e6:
	st r10,[sp, 0x2c]
L_9204ea:
	st r11,[sp, 0x30]
L_9204ee:
	st_s r12,[sp,0x34]
L_9204f0:
	st_s r13,[sp,0x38]
L_9204f2:
	st_s r14,[sp,0x3c]
L_9204f4:
	st_s r15,[sp,0x40]
L_9204f6:
	st r16,[sp, 0x44]
L_9204fa:
	st r17,[sp, 0x48]
L_9204fe:
	st r18,[sp, 0x4c]
L_920502:
	st r19,[sp, 0x50]
L_920506:
	st r20,[sp, 0x54]
L_92050a:
	st r21,[sp, 0x58]
L_92050e:
	st r22,[sp, 0x5c]
L_920512:
	st r23,[sp, 0x60]
L_920516:
	st r24,[sp, 0x64]
L_92051a:
	st r25,[sp, 0x68]
L_92051e:
	st gp,[sp, 0x6c]
L_920522:
	st sp,[sp, 0x70]
L_920526:
	st sp,[sp, 0x74]
L_92052a:
	st ilink1,[sp, 0x78]
L_92052e:
	st ilink2,[sp, 0x7c]
L_920532:
	st blink,[sp, 0x80]
L_920536:
	mov_s r14,blink
L_920538:
	bl.d L_920f9c
L_92053c:
	mov_s r15,ilink2
L_92053e:
	mov.f r13,r0
L_920542:
	beq_s L_920580
L_920544:
	norm r0,r0
L_920548:
	bl.d L_920fa8
L_92054c:
	rsub r0,r0,0x1e
L_920550:
	st_s r0,[sp,0x0]
L_920552:
	mov_s r1,0x10000c0
L_920558:
	mov_s r0,0x0
L_92055a:
	bl.d L_92d1d0
L_92055e:
	mov_s r2,r13
L_920560:
	mov_s r1,0x10000e4
L_920566:
	mov_s r0,0x0
L_920568:
	mov_s r2,r15
L_92056a:
	bl.d L_92d27c
L_92056e:
	ld_s r3,[sp,0x0]
L_920570:
	mov_s r1,0x100012c
L_920576:
	mov_s r0,0x0
L_920578:
	bl.d L_92d1d0
L_92057c:
	mov_s r2,r14
L_92057e:
	b_s L_92058c
	.global L_920580
L_920580:
	mov_s r1,0x1000160
L_920586:
	bl.d L_92d13c
L_92058a:
	mov_s r0,0x0
	.global L_92058c
L_92058c:
	mov_s r14,0x0
L_92058e:
	mov_s r13,0x10
	.global L_920590
L_920590:
	add2 r3,sp,r14
L_920594:
	ld_s r15,[r3,0x8]
L_920596:
	mov_s r1,0x1000184
L_92059c:
	ld_s r3,[r3,0x4]
L_92059e:
	mov_s r0,0x0
L_9205a0:
	mov_s r2,r14
L_9205a2:
	bl.d L_92d338
L_9205a6:
	mov_s r4,r15
L_9205a8:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_9205aa:
	/* brhs.d r13,0x1,0x00920590 */
	.byte 0xe9,0x0d,0x75,0x90
L_9205ae:
	/* _add_s r14,0x2 */
	.byte 0x02,0xe6
L_9205b0:
	bl L_92635c
L_9205b4:
	mov_s r0,blink
L_9205b6:
	bl.d L_926618
L_9205ba:
	mov_s r1,0x23
L_9205bc:
	b.d L_920254
L_9205c0:
	add sp,sp,0x84
