/* state_sm_8030f4__action_8f14d0 @ 0x8f14d0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND_SM:: dband beacon handle in SEARCH (%d) !
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, find_main_sm__bcon, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_8030f4__action_8f14d0
state_sm_8030f4__action_8f14d0:
	.global L_8f14d0
L_8f14d0:
	push_s blink
L_8f14d2:
	bl L_8c01e0
L_8f14d6:
	mov_s r15,r0
L_8f14d8:
	mov_s r14,r1
L_8f14da:
	mov_s r13,r2
L_8f14dc:
	mov_s r1,0x1017cb0
L_8f14e2:
	bl.d L_8dcc10
L_8f14e6:
	mov_s r0,0x2c
L_8f14e8:
	cmp_s r13,0x2
L_8f14ea:
	mov.eq r0,r15
L_8f14ee:
	mov.eq r1,r14
L_8f14f2:
	bl.eq.d L_8f13f8
L_8f14f6:
	mov.eq r2,r13
L_8f14fa:
	b L_8c024c
L_8f14fe:
	nop_s
