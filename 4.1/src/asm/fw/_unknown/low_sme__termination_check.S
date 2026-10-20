/* low_sme__termination_check @ 0x8e426c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   low_sme::termination_check(termination_evt=%d)
 *   low_sme::termination_check[termination_evt=%d]=0
 * Зовут его: frag_8e885c, l2_mgr__pcp_stop, l2mgr__disconnect_done, tail_low_sme__termination_check
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit1
 * Глобалы (через gp): 0x800170
 */
	.section .text.low_sme__termination_check,"ax",@progbits
	.global low_sme__termination_check
low_sme__termination_check:
	.global L_8e426c
L_8e426c:
	push_s blink
L_8e426e:
	push_s r13
L_8e4270:
	mov_s r13,r0
L_8e4272:
	mov_s r2,0x1009e88
L_8e4278:
	mov_s r0,0x0
L_8e427a:
	mov_s r1,0x2
L_8e427c:
	bl.d L_8edfcc
L_8e4280:
	mov_s r3,r13
L_8e4282:
	mov_s r1,0x0
L_8e4284:
	ld_s r0,[gp,0x0]
L_8e4286:
	bset r1,r1,r13
L_8e428a:
	tst_s r0,r1
L_8e428c:
	beq_s L_8e42bc
L_8e428e:
	bic_s r0,r0,r1
L_8e4290:
	st.as r0,[gp,0x0]
L_8e4294:
	mov_s r2,0x1009eb8
L_8e429a:
	mov_s r0,0x0
L_8e429c:
	mov_s r1,0x2
L_8e429e:
	bl.d L_8edfcc
L_8e42a2:
	mov_s r3,r13
L_8e42a4:
	ld_s r0,[gp,0x0]
L_8e42a6:
	brne_s r0,0,L_8e42bc
L_8e42a8:
	mov_s r0,0x8043d4
L_8e42ae:
	mov_s r1,0x2
L_8e42b0:
	mov_s r2,0x0
L_8e42b2:
	mov_s r3,0x0
L_8e42b4:
	bl.d L_8d6a1c
L_8e42b8:
	mov r4,0x0
	.global L_8e42bc
L_8e42bc:
	b L_8c033c
