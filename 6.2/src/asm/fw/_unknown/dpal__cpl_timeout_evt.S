/* dpal__cpl_timeout_evt @ 0x8c9680, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DPAL CPL TO Event: cpl_valid_vector = 0x%08X cpl_cnt0 = 0x%08X cpl_cnt1 = 0x%08X
 *   DPAL CPL TO Event: cpl_cnt2 = 0x%08X cpl_cnt3 = 0x%08X cpl_cnt4 = 0x%08X
 *   DPAL CPL TO Event: cpl_cnt5 = 0x%08X cpl_cnt6 = 0x%08X cpl_cnt7 = 0x%08X
 *   DB2 DOCK - GBE Completion Timeout Disconnect
 * Зовут его: hwd_dma__program_vring_desc, hwd_dma__set_ring_base
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log_emit0, fw_log_emit3, fw_sysassert_fatal, pcie__clear_cpl_timeout, vring_schd__disconnect_notify
 * Глобалы (через gp): 0x800340, 0x800344
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dpal__cpl_timeout_evt
dpal__cpl_timeout_evt:
	.global L_8c9680
L_8c9680:
	mov_s r1,r0
L_8c9682:
	ld_s r0,[gp,0x1c0]
L_8c9684:
	brne r0,0x1,L_8c9698
L_8c9688:
	ld_s r0,[gp,0x1bc]
L_8c968a:
	cmp_s r1,r0
L_8c968c:
	jeq_s [blink]
L_8c968e:
	mov_s r0,blink
L_8c9690:
	mov_s r1,0x6
L_8c9692:
	b.d L_8c9b28
L_8c9696:
	bset_s r1,r1,0xc
	.global L_8c9698
L_8c9698:
	mov_s r0,0x881c80
L_8c969e:
	st_s r1,[r0,0x8]
L_8c96a0:
	st.as r1,[gp,0x6f]
L_8c96a4:
	mov_s r0,0x1
L_8c96a6:
	j_s.d [blink]
L_8c96a8:
	st.as r0,[gp,0x70]
L_8c96ac:
	push_s blink
L_8c96ae:
	bl L_8c01cc
L_8c96b2:
	mov_s r0,0x882d00
L_8c96b8:
	ld_s r2,[r0,0x8]
L_8c96ba:
	ld_s r15,[r0,0xc]
L_8c96bc:
	extb_s r2,r2
L_8c96be:
	ld_s r1,[r0,0xc]
L_8c96c0:
	bmsk_s r15,r15,0x4
L_8c96c2:
	lsr_s r1,r1,0x8
L_8c96c4:
	ld_s r14,[r0,0xc]
L_8c96c6:
	bmsk r20,r1,0x4
L_8c96ca:
	lsr_s r14,r14,0x10
L_8c96cc:
	ld_s r3,[r0,0xc]
L_8c96ce:
	bmsk_s r14,r14,0x4
L_8c96d0:
	lsr_s r3,r3,0x18
L_8c96d2:
	bmsk r16,r3,0x4
L_8c96d6:
	ld_s r3,[r0,0x10]
L_8c96d8:
	mov_s r1,0x1003808
L_8c96de:
	bmsk r18,r3,0x4
L_8c96e2:
	ld_s r3,[r0,0x10]
L_8c96e4:
	lsr_s r3,r3,0x8
L_8c96e6:
	ld_s r13,[r0,0x10]
L_8c96e8:
	bmsk r17,r3,0x4
L_8c96ec:
	lsr_s r13,r13,0x10
L_8c96ee:
	ld_s r0,[r0,0x10]
L_8c96f0:
	bmsk_s r13,r13,0x4
L_8c96f2:
	lsr_s r0,r0,0x18
L_8c96f4:
	bmsk r19,r0,0x4
L_8c96f8:
	mov_s r0,0x2f
L_8c96fa:
	mov_s r3,r15
L_8c96fc:
	bl.d L_8dcd00
L_8c9700:
	mov r4,r20
L_8c9704:
	mov_s r1,0x100385c
L_8c970a:
	mov_s r0,0x2f
L_8c970c:
	mov_s r2,r14
L_8c970e:
	mov_s r3,r16
L_8c9710:
	bl.d L_8dcd00
L_8c9714:
	mov r4,r18
L_8c9718:
	mov_s r1,0x10038a8
L_8c971e:
	mov_s r0,0x2f
L_8c9720:
	mov_s r2,r17
L_8c9722:
	mov_s r3,r13
L_8c9724:
	bl.d L_8dcd00
L_8c9728:
	mov r4,r19
L_8c972c:
	cmp_s r15,0x7
L_8c972e:
	cmp.eq r20,0x7
L_8c9732:
	bne_s L_8c9760
L_8c9734:
	brge r18,r14,L_8c9760
L_8c9738:
	brne r14,r16,L_8c9760
L_8c973c:
	brge r13,r18,L_8c9760
L_8c9740:
	brne r18,r17,L_8c9760
L_8c9744:
	brlt r13,0x1,L_8c9760
L_8c9748:
	brne r13,r19,L_8c9760
L_8c974c:
	mov_s r1,0x10038f4
L_8c9752:
	bl.d L_8dcba8
L_8c9756:
	mov_s r0,0x1f
L_8c9758:
	bl.d L_8c91b8
L_8c975c:
	mov_s r0,0x1
L_8c975e:
	b_s L_8c9764
	.global L_8c9760
L_8c9760:
	bl L_8fa818
	.global L_8c9764
L_8c9764:
	b L_8c0224
