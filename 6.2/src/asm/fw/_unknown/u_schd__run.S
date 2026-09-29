/* u_schd__run @ 0x8e76a8, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LARGE TASK: FUNC address 0x%x, duration %d ms.
 * Зовут его: fw_main__enter_main_loop
 * Зовёт сам: deep_sleep_enter, fw_divmod_unsigned, fw_log_emit2, mem_pool__free_locked, u_schd__init_queue, u_schd__now, u_schd__pop_ready, u_schd__timer_init
 * Глобалы (через gp): 0x80019c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__run
u_schd__run:
	.global L_8e76a8
L_8e76a8:
	push_s blink
L_8e76aa:
	bl.d L_8e9508
L_8e76ae:
	mov_s r14,0x0
L_8e76b0:
	mov_s r13,0x2
	.global L_8e76b2
L_8e76b2:
	mov_s r0,0x803c54
L_8e76b8:
	bl.d L_8d9118
L_8e76bc:
	ld.as r0,[r0,r14]
L_8e76c0:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e76c2:
	/* brhs.d r13,0x1,0x008e76b2 */
	.byte 0xf3,0x0d,0x75,0x90
L_8e76c6:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8e76c8
L_8e76c8:
	bl L_8cc534
L_8e76cc:
	mov.f r14,r0
L_8e76d0:
	beq_s L_8e7716
L_8e76d2:
	bl.d L_8e9524
L_8e76d6:
	ld_s r13,[r14,0xc]
L_8e76d8:
	mov_s r15,r0
L_8e76da:
	ld_s r0,[r14,0x10]
L_8e76dc:
	jl_s.d [r13]
L_8e76de:
	ld_s r1,[r14,0x14]
L_8e76e0:
	bl L_8e9524
L_8e76e4:
	sub_s r0,r0,r15
L_8e76e6:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e76e8:
	mov_s r1,0x8004a0
L_8e76ee:
	ld_s r1,[r1]
L_8e76f0:
	abs_s r0,r0
L_8e76f2:
	brhs r1,r0,L_8e770e
L_8e76f6:
	bl.d L_8c02d4
L_8e76fa:
	mov r1,0x3e8
L_8e76fe:
	mov_s r3,r0
L_8e7700:
	mov_s r1,0x10016d4
L_8e7706:
	mov_s r0,0x10
L_8e7708:
	bl.d L_8dcc80
L_8e770c:
	mov_s r2,r13
	.global L_8e770e
L_8e770e:
	bl.d L_8cb028
L_8e7712:
	mov_s r0,r14
L_8e7714:
	b_s L_8e76c8
	.global L_8e7716
L_8e7716:
	bl L_8c87c0
L_8e771a:
	lr r1,[0xa]
L_8e771e:
	bclr r0,r1,0x1
L_8e7722:
	flag r0
L_8e7726:
	ld_s r0,[gp,0x18]
L_8e7728:
	brne_s r0,0,L_8e773a
L_8e772a:
	lr r0,[0xa]
L_8e772e:
	or r0,r0,0x6
L_8e7732:
	flag r0
L_8e7736:
	sleep 0x0
	.global L_8e773a
L_8e773a:
	lr r0,[0xa]
L_8e773e:
	bic r1,r1,-0x3
L_8e7742:
	or_s r0,r0,r1
L_8e7744:
	flag r0
L_8e7748:
	b_s L_8e76c8
L_8e774a:
	nop_s
