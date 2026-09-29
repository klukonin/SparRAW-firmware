/* schedule_long_term_trigger @ 0x8e476c, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   schedule_long_term_trigger mcs:%d max_goodput:%u timeout:%u
 * Зовут его: maintain_sm__action_8c494c, maintain_sm__action_8cdbd8, maintain_sm__action_8e2b9c
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_lt__get_max_goodput, fw_log_emit3, fw_sysassert_fatal, hw_rand__below_n, lt_bf__reset_trigger_period, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x8003cc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global schedule_long_term_trigger
schedule_long_term_trigger:
	.global L_8e476c
L_8e476c:
	push_s blink
L_8e476e:
	bl L_8c01dc
L_8e4772:
	mov_s r14,r0
L_8e4774:
	ld_s r0,[gp,-0x80]
L_8e4776:
	mov_s r13,r1
L_8e4778:
	brne r0,0x0,L_8e4814
L_8e477c:
	cmp_s r2,0x5
L_8e477e:
	mov_s r15,0x5
L_8e4780:
	ld_s r0,[gp,0x248]
L_8e4782:
	mov.cs r15,r2
L_8e4786:
	breq r0,0x0,L_8e4814
L_8e478a:
	mov_s r0,0x803c00
L_8e4790:
	ld_s r0,[r0,0xc]
L_8e4792:
	brne r0,0x0,L_8e4814
L_8e4796:
	brhs r13,0xd,L_8e4818
	.global L_8e479a
L_8e479a:
	ld_s r0,[r14,0x1c]
L_8e479c:
	breq_s r0,0,L_8e47a6
L_8e479e:
	bl L_8c8de0
L_8e47a2:
	mov_s r0,0x0
L_8e47a4:
	st_s r0,[r14,0x1c]
	.global L_8e47a6
L_8e47a6:
	mov_s r0,0x801448
L_8e47ac:
	ld.as r0,[r0,r13]
L_8e47b0:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8e47b2:
	mulu64 r0,r15
L_8e47b6:
	mov.f r15,mlo
L_8e47ba:
	beq_s L_8e4814
L_8e47bc:
	bl.d L_8e85f0
L_8e47c0:
	mov_s r0,0x0
L_8e47c2:
	bmsk_s r0,r0,0x3
L_8e47c4:
	/* mulu64 r0,0xbb8 */
	.byte 0x05,0x28,0x80,0x0f,0x00,0x00,0xb8,0x0b
L_8e47cc:
	add r16,mlo,r15
L_8e47d0:
	add r15,r14,0x2c
L_8e47d4:
	bl.d L_8cc3cc
L_8e47d8:
	mov_s r0,r15
L_8e47da:
	mov_s r4,r0
L_8e47dc:
	mov_s r1,0x101454c
L_8e47e2:
	mov_s r0,0x0
L_8e47e4:
	mov_s r2,r13
L_8e47e6:
	mov_s r3,r4
L_8e47e8:
	bl.d L_8dcd00
L_8e47ec:
	mov r4,r16
L_8e47f0:
	bl.d L_8e2958
L_8e47f4:
	mov_s r0,r15
L_8e47f6:
	mov_s r0,0x19c3c
L_8e47fc:
	mov_s r1,r14
L_8e47fe:
	mov_s r2,0x0
L_8e4800:
	mov_s r3,0x0
L_8e4802:
	mov r4,r16
L_8e4806:
	mov r5,0x0
L_8e480a:
	bl.d L_8e0c0c
L_8e480e:
	mov r6,0x0
L_8e4812:
	st_s r0,[r14,0x1c]
	.global L_8e4814
L_8e4814:
	b L_8c0244
	.global L_8e4818
L_8e4818:
	mov_s r0,blink
L_8e481a:
	mov_s r1,0x126d
L_8e4820:
	bl L_8c9b28
L_8e4824:
	b_s L_8e479a
L_8e4826:
	nop_s
