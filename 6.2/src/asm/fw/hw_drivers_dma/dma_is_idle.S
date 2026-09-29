/* dma_is_idle @ 0x8d08c0, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dma_is_idle: sw_head:0x%x, sw_head4read:0x%x
 * Зовут его: rm_main_sm__enter_primary_non_locked, sm_pring__timeout, sta_psc_sm__action_8c318c
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma_is_idle
dma_is_idle:
	.global L_8d08c0
L_8d08c0:
	push_s blink
L_8d08c2:
	bl L_8c01e4
L_8d08c6:
	mul64 r0,0x380
L_8d08ca:
	add r2,mlo,0x4409880
L_8d08d2:
	lsr_s r2,r2,0x3
L_8d08d4:
	bic r2,r2,0x3
L_8d08d8:
	ld_s r14,[r2]
L_8d08da:
	add r0,mlo,0x44098c0
L_8d08e2:
	lsr_s r0,r0,0x3
L_8d08e4:
	bic r0,r0,0x3
L_8d08e8:
	ld_s r13,[r0]
L_8d08ea:
	breq_s r1,0,L_8d08fc
L_8d08ec:
	mov_s r1,0x101d4f8
L_8d08f2:
	mov_s r0,0x20
L_8d08f4:
	mov_s r2,r14
L_8d08f6:
	bl.d L_8dcc80
L_8d08fa:
	mov_s r3,r13
	.global L_8d08fc
L_8d08fc:
	cmp_s r14,r13
L_8d08fe:
	mov_s r0,0x1
L_8d0900:
	b.d L_8c0254
L_8d0904:
	sub_s.ne r0,r0,r0
L_8d0906:
	nop_s
