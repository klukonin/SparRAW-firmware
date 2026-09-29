/* conn_main_sm__action_8c475c @ 0x8c475c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LINKUP Failure PCP Assoc ready = 0!!!
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, fw_log_emit0, lm_if__on_linkup_ready, lmac_if__send_cmd_04_thunk, maintain_ctx__set_field_9c, sm__defer_call, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_8c475c
conn_main_sm__action_8c475c:
	.global L_8c475c
L_8c475c:
	push_s blink
L_8c475e:
	bl L_8c01e0
L_8c4762:
	mov_s r13,r0
L_8c4764:
	ld_s r0,[r0,0x2c]
L_8c4766:
	mov_s r15,r1
L_8c4768:
	mov_s r14,r2
L_8c476a:
	breq_s r0,0,L_8c4774
L_8c476c:
	bl L_8c8de0
L_8c4770:
	mov_s r0,0x0
L_8c4772:
	st_s r0,[r13,0x2c]
	.global L_8c4774
L_8c4774:
	bl.d L_8db718
L_8c4778:
	mov_s r0,0x2
L_8c477a:
	ld_s r0,[r13,0x8]
L_8c477c:
	ld_s r1,[r0,0x24]
L_8c477e:
	add_s r0,r0,0x70
L_8c4780:
	cmp_s r1,0x1
L_8c4782:
	mov_s r1,0x2
L_8c4784:
	mov.ne r1,0x1
L_8c4788:
	bl L_8ea9c8
L_8c478c:
	ld_s r0,[r13,0x8]
L_8c478e:
	ld_s r1,[r0,0x2c]
L_8c4790:
	breq_s r1,0,L_8c47a2
L_8c4792:
	mov_s r0,r13
L_8c4794:
	mov_s r1,0x2
L_8c4796:
	mov_s r2,0x0
L_8c4798:
	mov_s r3,r2
L_8c479a:
	bl.d L_8d9b6c
L_8c479e:
	mov_s r4,r2
L_8c47a0:
	b_s L_8c47dc
	.global L_8c47a2
L_8c47a2:
	brne_s r15,0,L_8c47ba
L_8c47a4:
	breq_s r14,0,L_8c47ce
L_8c47a6:
	ld_s r1,[r14,0xc]
L_8c47a8:
	ld r1,[r1, 0xc0]
L_8c47ac:
	ldb_s r1,[r1,0x5]
L_8c47ae:
	btst_s r1,0x3
L_8c47b0:
	bic.eq.f r1,r1,0xffffffcf
L_8c47b8:
	beq_s L_8c47c2
	.global L_8c47ba
L_8c47ba:
	bl.d L_8dae84
L_8c47be:
	add_s r0,r0,0x70
L_8c47c0:
	b_s L_8c47dc
	.global L_8c47c2
L_8c47c2:
	mov_s r1,0x1011a08
L_8c47c8:
	bl.d L_8dcba8
L_8c47cc:
	mov_s r0,0xb
	.global L_8c47ce
L_8c47ce:
	mov_s r0,r13
L_8c47d0:
	mov_s r1,0x2
L_8c47d2:
	mov_s r2,0x1
L_8c47d4:
	mov_s r3,0x0
L_8c47d6:
	bl.d L_8e7044
L_8c47da:
	mov_s r4,r3
	.global L_8c47dc
L_8c47dc:
	b L_8c024c
