/* background_task__dispatch @ 0x9215d0, 296 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: background_bi_step, bf_pending__clear_bit, bg_task__call_cb20, l1_task__kick_and_dispatch_uc, mac_mode__switch_sequence, rs_end, uc_sysassert
 * Глобалы (через gp): 0x800584, 0x80058c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global background_task__dispatch
background_task__dispatch:
	.byte 0x00
	.byte 0x00
	.global L_9215d2
L_9215d2:
	mov_s r14,0x800648
L_9215d8:
	ld_s r1,[r14]
L_9215da:
	ld_s r0,[gp,0x5c]
L_9215dc:
	tst_s r0,r1
L_9215de:
	beq_s L_9216a8
L_9215e0:
	mov_s r0,0x0
L_9215e2:
	st.as r0,[gp,0x19]
L_9215e6:
	lr r13,[0xa]
L_9215ea:
	bclr r0,r13,0x1
L_9215ee:
	flag r0
L_9215f2:
	ld_s r1,[r14]
L_9215f4:
	ld_s r0,[gp,0x5c]
L_9215f6:
	and.f r0,r0,r1
L_9215fa:
	mov_s r1,0x0
L_9215fc:
	beq_s L_921610
L_9215fe:
	norm r0,r0
L_921602:
	rsub r1,r0,0x1e
L_921606:
	ld_s r0,[gp,0x64]
L_921608:
	bset r0,r0,r1
L_92160c:
	st.as r0,[gp,0x19]
	.global L_921610
L_921610:
	brhs r1,0x6,L_92169e
L_921614:
	ldb.x r1,[0x8017d8,r1]
L_92161c:
	add r0,pcl,0x8
L_921620:
	add1_s r0,r0,r1
L_921622:
	j_s [r0]
L_921624:
	bl.d L_921750
L_921628:
	mov_s r0,0x5
L_92162a:
	bl L_927378
L_92162e:
	b_s L_9215c4
L_921630:
	bl.d L_921750
L_921634:
	mov_s r0,0x2
L_921636:
	bl L_92fdb4
L_92163a:
	b_s L_9215c4
L_92163c:
	mov_s r0,0x886d80
L_921642:
	ld_s r0,[r0,0x50]
L_921644:
	bbit1 r0,0x0,L_921656
	.global L_921648
L_921648:
	bl.d L_921750
L_92164c:
	mov_s r0,0x3
L_92164e:
	bl.d L_9273c0
L_921652:
	mov_s r0,0x1
L_921654:
	b_s L_9215c4
	.global L_921656
L_921656:
	mov_s r0,blink
L_921658:
	mov_s r1,0x1318
L_92165e:
	bl L_926618
L_921662:
	b_s L_921648
L_921664:
	mov_s r0,0x886d80
L_92166a:
	ld_s r0,[r0,0x50]
L_92166c:
	bbit1 r0,0x1,L_92167e
	.global L_921670
L_921670:
	bl.d L_921750
L_921674:
	mov_s r0,0x4
L_921676:
	bl.d L_9273c0
L_92167a:
	mov_s r0,0x0
L_92167c:
	b_s L_9215c4
	.global L_92167e
L_92167e:
	mov_s r0,blink
L_921680:
	mov_s r1,0x1319
L_921686:
	bl L_926618
L_92168a:
	b_s L_921670
L_92168c:
	bl.d L_921750
L_921690:
	mov_s r0,0x0
L_921692:
	mov_s r0,0x803134
L_921698:
	bl L_925040
L_92169c:
	b_s L_9215c4
	.global L_92169e
L_92169e:
	mov_s r0,blink
L_9216a0:
	bl.d L_926618
L_9216a4:
	mov_s r1,0x31
L_9216a6:
	b_s L_9215c4
	.global L_9216a8
L_9216a8:
	lr r13,[0xa]
L_9216ac:
	bclr r0,r13,0x1
L_9216b0:
	flag r0
L_9216b4:
	bl.d L_93c6d8
L_9216b8:
	bic r13,r13,-0x3
L_9216bc:
	lr r0,[0xa]
L_9216c0:
	or_s r0,r0,r13
L_9216c2:
	flag r0
L_9216c6:
	lr r1,[0xa]
L_9216ca:
	bclr r0,r1,0x1
L_9216ce:
	flag r0
L_9216d2:
	ld_s r2,[r14]
L_9216d4:
	ld_s r0,[gp,0x5c]
L_9216d6:
	tst_s r0,r2
L_9216d8:
	bne_s L_9216ea
L_9216da:
	lr r0,[0xa]
L_9216de:
	or r0,r0,0x6
L_9216e2:
	flag r0
L_9216e6:
	sleep 0x0
	.global L_9216ea
L_9216ea:
	lr r0,[0xa]
L_9216ee:
	bic r1,r1,-0x3
L_9216f2:
	or_s r0,r0,r1
L_9216f4:
	b_s L_9215ce
L_9216f6:
	nop_s
