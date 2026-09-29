/* instruction_error__report @ 0x8c442c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Bad instruction (attempt to access ICCM).
 *   Reason: ST/LD cmd before [ilink2=0x%X] (address being accessed is 0x%X)
 *   If the above address is not us - check [blink=0x%X]
 *   Bad instruction (unknown action point %X)
 *   Bad instruction (unknown reason)
 *   regs%u: %08x %08x
 * Зовут его: fw_vector_02
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, arc__debug_cause, arc__read_aux_by_index, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global instruction_error__report
instruction_error__report:
	.global L_8c442c
L_8c442c:
	push_s blink
L_8c442e:
	bl L_8c01d4
L_8c4432:
	mov_s r18,r0
L_8c4434:
	mov_s r17,r1
L_8c4436:
	bl.d L_8c3b50
L_8c443a:
	mov_s r15,r2
L_8c443c:
	mov.f r2,r0
L_8c4440:
	beq_s L_8c4488
L_8c4442:
	bbit0 r2,0x1,L_8c447a
L_8c4446:
	bl.d L_8c3b5c
L_8c444a:
	mov_s r0,0x1
L_8c444c:
	mov_s r16,r0
L_8c444e:
	mov_s r1,0x10000a0
L_8c4454:
	bl.d L_8dcba8
L_8c4458:
	mov_s r0,0x0
L_8c445a:
	mov_s r1,0x10000cc
L_8c4460:
	mov_s r0,0x0
L_8c4462:
	mov_s r2,r17
L_8c4464:
	bl.d L_8dcc80
L_8c4468:
	mov_s r3,r16
L_8c446a:
	mov_s r1,0x1000114
L_8c4470:
	mov_s r0,0x0
L_8c4472:
	bl.d L_8dcc10
L_8c4476:
	mov_s r2,r18
L_8c4478:
	b_s L_8c4494
	.global L_8c447a
L_8c447a:
	mov_s r1,0x1000148
L_8c4480:
	bl.d L_8dcc10
L_8c4484:
	mov_s r0,0x0
L_8c4486:
	b_s L_8c4494
	.global L_8c4488
L_8c4488:
	mov_s r1,0x1000174
L_8c448e:
	bl.d L_8dcba8
L_8c4492:
	mov_s r0,0x0
	.global L_8c4494
L_8c4494:
	mov_s r14,0x0
L_8c4496:
	mov_s r13,0x10
	.global L_8c4498
L_8c4498:
	mov_s r1,0x1000198
L_8c449e:
	add2 r3,r15,r14
L_8c44a2:
	ld r4,[r3, 0x4]
L_8c44a6:
	mov_s r0,0x0
L_8c44a8:
	mov_s r2,r14
L_8c44aa:
	bl.d L_8dcd00
L_8c44ae:
	ld_s r3,[r3]
L_8c44b0:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8c44b2:
	/* brhs.d r13,0x1,0x008c4498 */
	.byte 0xe9,0x0d,0x75,0x90
L_8c44b6:
	/* _add_s r14,0x2 */
	.byte 0x02,0xe6
L_8c44b8:
	b L_8c0234
