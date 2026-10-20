/* uc_hwd_phy_pwr @ 0x92709c, 436 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hw_drivers_phy.c
 *   hwd_phy_pwr ON: phy_tx_power_ack =%d,phy_rx_power_ack = %d,phy_ldpc_power_ack=%d
 * Зовут его: dma_mac_setup_step
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_hwd_phy_pwr,"ax",@progbits
	.global uc_hwd_phy_pwr
uc_hwd_phy_pwr:
	.global L_92709c
L_92709c:
	st.a r13,[sp,-0x14]
L_9270a0:
	st blink,[sp, 0x4]
L_9270a4:
	st_s r14,[sp,0x8]
L_9270a6:
	st_s r15,[sp,0xc]
L_9270a8:
	bclr.f r14,r0,0x0
L_9270ac:
	st r16,[sp, 0x10]
L_9270b0:
	bne.d L_927208
L_9270b4:
	mov r13,r0
	.global L_9270b8
L_9270b8:
	cmp_s r14,0x0
L_9270ba:
	bne_s L_927220
	.global L_9270bc
L_9270bc:
	cmp_s r14,0x0
L_9270be:
	bne_s L_927238
	.global L_9270c0
L_9270c0:
	mov r4,0x881000
L_9270c8:
	ld.as r8,[r4,-0xe2]
L_9270cc:
	asl r7,r13
L_9270d0:
	bclr r8,r8,0x0
L_9270d4:
	or r8,r8,r13
L_9270d8:
	bclr r8,r8,0x1
L_9270dc:
	or r7,r7,r8
L_9270e0:
	bclr r7,r7,0x2
L_9270e4:
	asl r6,r13,0x2
L_9270e8:
	or r6,r6,r7
L_9270ec:
	st.as r6,[r4,-0xe2]
L_9270f0:
	mov lp_count,0xc8
L_9270f4:
	mov 0x0,0x0
L_9270f8:
	lp L_92711c
L_9270fc:
	ld.as r2,[r4,-0xe1]
L_927100:
	bmsk r16,r2,0x0
L_927104:
	lsr_s r14,r2
L_927106:
	lsr_s r2,r2,0x2
L_927108:
	bmsk_s r14,r14,0x0
L_92710a:
	bmsk r15,r2,0x0
L_92710e:
	cmp_s r13,r16
L_927110:
	cmp.eq r13,r14
L_927114:
	cmp.eq r13,r15
L_927118:
	beq_s L_92711c
L_92711a:
	nop_s
	.global L_92711c
L_92711c:
	cmp_s r13,r16
L_92711e:
	cmp.eq r13,r14
L_927122:
	cmp.eq r13,r15
L_927126:
	beq_s L_927180
L_927128:
	mov r8,0x80209c
L_927130:
	ldb r10,[r8, 0x4]
L_927134:
	mov_s r3,0x1003494
L_92713a:
	mov_s r2,0x1003448
L_927140:
	bbit0 r10,0x0,L_927170
L_927144:
	bmsk r3,r3,0x13
L_927148:
	ld r4,[r8]
L_92714c:
	or r3,r3,0xa0000000
L_927154:
	extb r10,r4
L_927158:
	mov r9,0x8020b0
L_927160:
	add2 r10,r9,r10
L_927164:
	st r3,[r10]
L_927168:
	add r4,r4,0x1
L_92716c:
	st r4,[r8]
	.global L_927170
L_927170:
	mov_s r0,blink
L_927172:
	mov_s r1,0x1334
L_927178:
	bl.d L_925548
L_92717c:
	mov r3,0x5cf
	.global L_927180
L_927180:
	cmp_s r13,r16
L_927182:
	cmp.eq r13,r15
L_927186:
	cmp.eq r13,r14
L_92718a:
	beq_s L_9271f4
L_92718c:
	mov r7,0x80209c
L_927194:
	ldb r11,[r7, 0xd]
L_927198:
	mov_s r1,0x10035a4
L_92719e:
	bbit0 r11,0x0,L_9271f4
L_9271a2:
	ld r5,[r7]
L_9271a6:
	mov r6,0x8020b0
L_9271ae:
	add r9,r5,0x3
L_9271b2:
	extb r9,r9
L_9271b6:
	add2 r9,r6,r9
L_9271ba:
	st r15,[r9]
L_9271be:
	add r0,r5,0x2
L_9271c2:
	extb_s r0,r0
L_9271c4:
	add2 r0,r6,r0
L_9271c8:
	st_s r14,[r0]
L_9271ca:
	add r2,r5,0x1
L_9271ce:
	extb_s r2,r2
L_9271d0:
	add2 r2,r6,r2
L_9271d4:
	st r16,[r2]
L_9271d8:
	bmsk_s r1,r1,0x13
L_9271da:
	or r1,r1,0xac900000
L_9271e2:
	extb r3,r5
L_9271e6:
	add2 r3,r6,r3
L_9271ea:
	st_s r1,[r3]
L_9271ec:
	add r5,r5,0x4
L_9271f0:
	st r5,[r7]
	.global L_9271f4
L_9271f4:
	ld blink,[sp, 0x4]
L_9271f8:
	ld_s r14,[sp,0x8]
L_9271fa:
	ld_s r15,[sp,0xc]
L_9271fc:
	ld r16,[sp, 0x10]
L_927200:
	j.d [blink]
L_927204:
	ld.ab r13,[sp,0x14]
	.global L_927208
L_927208:
	mov_s r0,blink
L_92720a:
	mov_s r2,0x1003448
L_927210:
	mov r1,0xaf
L_927214:
	bl.d L_925548
L_927218:
	mov r3,0x5c2
L_92721c:
	b L_9270b8
	.global L_927220
L_927220:
	mov_s r0,blink
L_927222:
	mov_s r2,0x1003448
L_927228:
	mov r1,0xb0
L_92722c:
	bl.d L_925548
L_927230:
	mov r3,0x5c2
L_927234:
	b L_9270bc
	.global L_927238
L_927238:
	mov_s r0,blink
L_92723a:
	mov_s r2,0x1003448
L_927240:
	mov r1,0xb1
L_927244:
	bl.d L_925548
L_927248:
	mov r3,0x5c2
L_92724c:
	b_s L_9270c0
L_92724e:
	nop_s
