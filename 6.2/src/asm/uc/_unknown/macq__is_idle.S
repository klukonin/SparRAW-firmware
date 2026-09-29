/* macq__is_idle @ 0x92609c, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_is_tx_pipe_idle, fixed_sched__slot_prepare, macq__kick_queue_tx, vring__disconnect_flush
 * Зовёт сам: __ld_r13_to_r13_ret, qh__read_desc_window
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq__is_idle
macq__is_idle:
	.global L_92609c
L_92609c:
	push_s blink
L_92609e:
	push_s r13
L_9260a0:
	mov_s r13,r0
L_9260a2:
	ld_s r0,[gp,-0x44]
L_9260a4:
	sub_s sp,sp,0x10
L_9260a6:
	and r0,r0,0xfffff0ff
L_9260ae:
	bset r1,r0,0x8
L_9260b2:
	bset_s r1,r1,0x9
L_9260b4:
	bset_s r1,r1,0xb
L_9260b6:
	st.as r1,[gp,-0x11]
L_9260ba:
	or r0,r0,0x1d000b00
L_9260c2:
	mov_s r32,r0
L_9260c4:
	st.ab r0,[r25,0x4]
L_9260c8:
	bclr r25,r25,0xa
L_9260cc:
	nop_s
L_9260ce:
	nop_s
L_9260d0:
	nop_s
L_9260d2:
	mov_s r0,0x8006ec
L_9260d8:
	st r41,[r0, 0x18]
L_9260dc:
	ld_s r0,[gp,-0x44]
L_9260de:
	and r0,r0,0xfffff0ff
L_9260e6:
	bset r1,r0,0xa
L_9260ea:
	bset_s r1,r1,0xb
L_9260ec:
	or r0,r0,0x1d000c00
L_9260f4:
	st.as r1,[gp,-0x11]
L_9260f8:
	mov_s r32,r0
L_9260fa:
	st.ab r0,[r25,0x4]
L_9260fe:
	bclr r25,r25,0xa
L_926102:
	nop_s
L_926104:
	nop_s
L_926106:
	nop_s
L_926108:
	mov_s r1,r41
L_92610a:
	mov_s r0,0x8006ec
L_926110:
	st_s r1,[r0,0x1c]
L_926112:
	mov_s r2,0x0
L_926114:
	ld_s r0,[r0,0x18]
L_926116:
	bset r2,r2,r13
L_92611a:
	tst_s r2,r0
L_92611c:
	tst.eq r2,r1
L_926120:
	mov_s r0,0x0
L_926122:
	beq_s L_926126
L_926124:
	mov_s r0,0x1
	.global L_926126
L_926126:
	extb.f 0x0,r0
L_92612a:
	bne_s L_926174
L_92612c:
	mov_s r0,sp
L_92612e:
	mov_s r1,r13
L_926130:
	mov_s r2,0x2
L_926132:
	mov_s r13,0x0
L_926134:
	mov_s r3,r13
L_926136:
	bl.d L_92449c
L_92613a:
	mov r4,0x1
L_92613e:
	ld_s r0,[sp,0xc]
L_926140:
	ldb r2,[sp, 0xb]
L_926144:
	bmsk_s r0,r0,0x3
L_926146:
	asl_s r0,r0,0x8
L_926148:
	or_s r2,r2,r0
L_92614a:
	ld_s r0,[sp,0x8]
L_92614c:
	ldw r1,[sp]
L_926150:
	lsr_s r0,r0,0xc
L_926152:
	bmsk_s r0,r0,0xb
L_926154:
	cmp_s r2,r0
L_926156:
	mov_s r2,0x1
L_926158:
	ldw r0,[sp, 0x2]
L_92615c:
	sub_s.ne r2,r2,r2
L_92615e:
	cmp_s r1,r0
L_926160:
	mov_s r0,0x1
L_926162:
	sub_s.ne r0,r0,r0
L_926164:
	cmp_s r2,0x0
L_926166:
	cmp.ne r0,0x0
L_92616a:
	mov.ne r13,0x1
L_92616e:
	extb.f 0x0,r13
L_926172:
	bne_s L_926178
	.global L_926174
L_926174:
	mov_s r0,0x0
L_926176:
	b_s L_92617a
	.global L_926178
L_926178:
	mov_s r0,0x1
	.global L_92617a
L_92617a:
	extb_s r0,r0
L_92617c:
	b.d L_9202ac
L_926180:
	add_s sp,sp,0x10
L_926182:
	nop_s
