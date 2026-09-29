/* rate_search__build_mcs_mask @ 0x92c1fc, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rate_search.c
 * Зовут его: rate_search__reset_stats, rate_search__start_for_sta
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, uc_sysassert
 */
	.section .text.rate_search__build_mcs_mask,"ax",@progbits
	.global rate_search__build_mcs_mask
rate_search__build_mcs_mask:
	.global L_92c1fc
L_92c1fc:
	push_s blink
L_92c1fe:
	bl.d L_920210
L_92c202:
	mul64 r0,0x2c
L_92c206:
	mov_s r1,0x801754
L_92c20c:
	ldb r1,[r1,mlo]
L_92c210:
	mov_s r14,0x0
L_92c212:
	mul64 r0,0x26
L_92c216:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92c218:
	rsub r2,r1,0x20
L_92c21c:
	mov r3,-0x1
L_92c220:
	cmp_s r1,0x0
L_92c222:
	lsr r13,r3,r2
L_92c226:
	add r15,mlo,0x801898
L_92c22e:
	mov.ne r1,r13
L_92c232:
	mov.eq r1,r3
L_92c236:
	ldw_s r0,[r15,0x24]
L_92c238:
	ldw_s r13,[r15,0x22]
L_92c23a:
	asl_s r0,r0,0x10
L_92c23c:
	or_s r13,r13,r0
L_92c23e:
	bic_s r13,r13,r1
L_92c240:
	b_s L_92c244
	.global L_92c242
L_92c242:
	mov_s r13,r0
	.global L_92c244
L_92c244:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_92c246:
	ldw_s r1,[r15,0x24]
L_92c248:
	ldw_s r0,[r15,0x22]
L_92c24a:
	asl_s r1,r1,0x10
L_92c24c:
	or_s r0,r0,r1
L_92c24e:
	norm r0,r0
L_92c252:
	rsub r1,r0,0x1e
L_92c256:
	brlo r1,r14,L_92c266
	.global L_92c25a
L_92c25a:
	lsr_s r0,r13
L_92c25c:
	bbit0 r13,0x1,L_92c242
L_92c260:
	b.d L_92027c
L_92c264:
	mov_s r0,r14
	.global L_92c266
L_92c266:
	mov_s r0,blink
L_92c268:
	mov_s r2,0x10016ac
L_92c26e:
	mov_s r1,0x1
L_92c270:
	bl.d L_925548
L_92c274:
	mov_s r3,0xa4
L_92c276:
	b_s L_92c25a
