/* u_schd__large_task_warn @ 0x8e2454, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LARGE TASK: FUNC address 0x%x, duration %d ms.
 * Зовут его: tail_u_schd__large_task_warn
 * Зовёт сам: deep_sleep_enter, fw_div_unsigned, fw_log__emit2, fw_read_timer, mem_pool__free_locked, power__enter_halt, u_schd__init_queue, u_schd__pick_next
 * Глобалы (через gp): 0x800190
 */
	.section .text.u_schd__large_task_warn,"ax",@progbits
	.global u_schd__large_task_warn
u_schd__large_task_warn:
	.global L_8e2454
L_8e2454:
	push_s blink
L_8e2456:
	bl.d L_8e4678
L_8e245a:
	mov_s r14,0x0
L_8e245c:
	mov_s r13,0x2
	.global L_8e245e
L_8e245e:
	mov_s r0,0x8034a8
L_8e2464:
	bl.d L_8d6088
L_8e2468:
	ld.as r0,[r0,r14]
L_8e246c:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e246e:
	/* brhs.d r13,0x1,0x008e245e */
	.byte 0xf3,0x0d,0x75,0x90
L_8e2472:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8e2474
L_8e2474:
	bl L_8ca30c
L_8e2478:
	mov.f r14,r0
L_8e247c:
	beq_s L_8e24c4
L_8e247e:
	bl.d L_8e4694
L_8e2482:
	ld_s r13,[r14,0xc]
L_8e2484:
	mov_s r15,r0
L_8e2486:
	ld_s r0,[r14,0x10]
L_8e2488:
	jl_s.d [r13]
L_8e248a:
	ld_s r1,[r14,0x14]
L_8e248c:
	bl L_8e4694
L_8e2490:
	sub_s r0,r0,r15
L_8e2492:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e2494:
	mov_s r1,0x800478
L_8e249a:
	ld_s r1,[r1]
L_8e249c:
	abs_s r0,r0
L_8e249e:
	brhs r1,r0,L_8e24bc
L_8e24a2:
	bl.d L_8c03b4
L_8e24a6:
	mov r1,0x3e8
L_8e24aa:
	mov_s r4,r0
L_8e24ac:
	mov_s r2,0x1001714
L_8e24b2:
	mov_s r0,0x0
L_8e24b4:
	mov_s r1,0x1
L_8e24b6:
	bl.d L_8edff8
L_8e24ba:
	mov_s r3,r13
	.global L_8e24bc
L_8e24bc:
	bl.d L_8c93f4
L_8e24c0:
	mov_s r0,r14
L_8e24c2:
	b_s L_8e2474
	.global L_8e24c4
L_8e24c4:
	bl L_8c71b8
L_8e24c8:
	lr r1,[0xa]
L_8e24cc:
	bclr r0,r1,0x1
L_8e24d0:
	flag r0
L_8e24d4:
	ld_s r0,[gp,0x20]
L_8e24d6:
	brne_s r0,0,L_8e24e8
L_8e24d8:
	lr r0,[0xa]
L_8e24dc:
	or r0,r0,0x6
L_8e24e0:
	flag r0
L_8e24e4:
	sleep 0x0
	.global L_8e24e8
L_8e24e8:
	lr r0,[0xa]
L_8e24ec:
	bic r1,r1,-0x3
L_8e24f0:
	or_s r0,r0,r1
L_8e24f2:
	flag r0
L_8e24f6:
	b_s L_8e2474
