/* sta_psc_sm__action_8c318c @ 0x8c318c, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PRING#%d V-Ring %d, ALL WB DONE and DMA or MAC isn't empty.
 *   Spurious event of ALL WB DONE  at <%d>.
 * Зовут его: rm_sm__action_8e0eb0
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, dma_is_idle, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, rm_main_sm__enter_step, sta_psc_sm__psc_done_sm, tx_macq__is_empty, u_schd__cancel, u_schd__now, vring_tbl__entry_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__action_8c318c
sta_psc_sm__action_8c318c:
	.global L_8c318c
L_8c318c:
	b.d L_8e194c
L_8c3190:
	mov_s r1,0x1
L_8c3192:
	nop_s
	.global L_8c3194
L_8c3194:
	push_s blink
L_8c3196:
	bl L_8c01dc
L_8c319a:
	mov_s r13,r0
L_8c319c:
	bl.d L_8ccfd8
L_8c31a0:
	ldw_s r0,[r0,0x2]
L_8c31a2:
	mov_s r14,0x0
L_8c31a4:
	mov_s r16,r0
L_8c31a6:
	ldw_s r0,[r13]
L_8c31a8:
	bl.d L_8d08c0
L_8c31ac:
	mov_s r1,r14
L_8c31ae:
	breq_s r0,0,L_8c31ba
L_8c31b0:
	mov_s r0,r16
L_8c31b2:
	bl.d L_8da15c
L_8c31b6:
	mov_s r1,r14
L_8c31b8:
	brne_s r0,0,L_8c31cc
	.global L_8c31ba
L_8c31ba:
	ldw_s r2,[r13]
L_8c31bc:
	mov_s r1,0x100d204
L_8c31c2:
	mov_s r0,0x27
L_8c31c4:
	bl.d L_8dcc80
L_8c31c8:
	ldw_s r3,[r13,0x2]
L_8c31ca:
	b_s L_8c3242
	.global L_8c31cc
L_8c31cc:
	ld_s r0,[r13,0x24]
L_8c31ce:
	breq_s r0,0,L_8c31d6
L_8c31d0:
	bl L_8c8de0
L_8c31d4:
	st_s r14,[r13,0x24]
	.global L_8c31d6
L_8c31d6:
	ld_s r1,[r13,0x18]
L_8c31d8:
	brhs r1,0x5,L_8c3236
L_8c31dc:
	ldb.x r1,[0x8023f4,r1]
L_8c31e4:
	add r0,pcl,0x8
L_8c31e8:
	add1_s r0,r0,r1
L_8c31ea:
	j_s [r0]
L_8c31ec:
	mov_s r0,r16
L_8c31ee:
	bl.d L_8da15c
L_8c31f2:
	mov_s r1,0x0
L_8c31f4:
	breq_s r0,0,L_8c31fe
	.global L_8c31f6
L_8c31f6:
	bl.d L_8c6954
L_8c31fa:
	mov_s r0,r13
L_8c31fc:
	b_s L_8c3242
	.global L_8c31fe
L_8c31fe:
	mov_s r0,blink
L_8c3200:
	mov_s r1,0x12ac
L_8c3206:
	bl L_8c9b28
L_8c320a:
	b_s L_8c31f6
L_8c320c:
	bl L_8e9524
L_8c3210:
	mov_s r1,0x100d240
L_8c3216:
	mov_s r2,r0
L_8c3218:
	mov_s r0,0x27
L_8c321a:
	/* bl.d 0x008dcc10 */
	.byte 0xfa,0x09,0xe0,0x0c
L_8c321e:
	/* _asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_8c3220:
	b_s L_8c3242
L_8c3222:
	bl L_8e9524
L_8c3226:
	mov_s r1,0x100d240
L_8c322c:
	mov_s r2,r0
L_8c322e:
	mov_s r0,0x27
L_8c3230:
	bl.d L_8dcc10
L_8c3234:
	/* _asl_s r2,r2,0x4 */
	.byte 0x04,0xba
	.global L_8c3236
L_8c3236:
	mov_s r0,blink
L_8c3238:
	mov_s r1,0x12ad
L_8c323e:
	bl L_8c9b28
	.global L_8c3242
L_8c3242:
	b L_8c0244
L_8c3246:
	nop_s
