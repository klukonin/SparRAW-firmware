/* keep_alive__arm_slot @ 0x939484, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x26_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, internal_tx__check_idle, uc_res_vote__acquire
 * Глобалы (через gp): 0x800570
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global keep_alive__arm_slot
keep_alive__arm_slot:
	.global L_939484
L_939484:
	push_s blink
L_939486:
	bl L_920234
L_93948a:
	mov_s r13,r0
L_93948c:
	mov_s r14,0x0
L_93948e:
	bset r14,r14,r0
L_939492:
	ld_s r0,[gp,0x48]
L_939494:
	or_s r0,r0,r14
L_939496:
	st.as r0,[gp,0x12]
L_93949a:
	bl.d L_92bd30
L_93949e:
	mov_s r0,0x2
L_9394a0:
	bl.d L_92bac8
L_9394a4:
	mov_s r0,0x2
L_9394a6:
	mov_s r0,0x80207c
L_9394ac:
	ld_s r0,[r0,0x34]
L_9394ae:
	breq_s r0,0,L_9394bc
L_9394b0:
	mov_s r1,0x857180
L_9394b6:
	ld_s r0,[r1,0x44]
L_9394b8:
	or_s r0,r0,r14
L_9394ba:
	st_s r0,[r1,0x44]
	.global L_9394bc
L_9394bc:
	mov_s r0,0x0
L_9394be:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_9394c0:
	add2_s r13,r13,r13
L_9394c2:
	add_s r13,r13,0x857e38
L_9394c8:
	stb_s r0,[r13,0x7]
L_9394ca:
	b.d L_9202a4
L_9394ce:
	stb_s r0,[r13,0x9]
