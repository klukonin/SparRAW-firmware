/* handle_bf_triggers @ 0x928750, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   handle_bf_triggers cid:%d set:%d triggers:%x
 * Зовут его: internal_tx__flow_sm2, internal_tx__flow_sm6, sends_pmc_mark_aaab20, tx_sta__run_txop
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf__trigger_for_mid, uc_log__emit3
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global handle_bf_triggers
handle_bf_triggers:
	.global L_928750
L_928750:
	push_s blink
L_928752:
	bl.d L_920234
L_928756:
	mov_s r3,r1
L_928758:
	mov_s r13,r0
L_92875a:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92875c:
	add2_s r0,r0,r0
L_92875e:
	mov_s r1,0x857e49
L_928764:
	ldb_s r14,[r1,r0]
L_928766:
	mov_s r0,r14
L_928768:
	bic r0,r0,-0xc0
L_92876c:
	sub.f r0,r0,0x0
L_928770:
	mov.ne r0,0x1
L_928774:
	extb.f 0x0,r0
L_928778:
	beq_s L_928790
L_92877a:
	mov_s r1,0x1000d94
L_928780:
	mov_s r0,0x20
L_928782:
	mov_s r2,r13
L_928784:
	bl.d L_92d338
L_928788:
	mov_s r4,r14
L_92878a:
	bl.d L_92eb68
L_92878e:
	mov_s r0,r13
	.global L_928790
L_928790:
	b L_9202a4
