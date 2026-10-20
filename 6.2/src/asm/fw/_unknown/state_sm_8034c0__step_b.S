/* state_sm_8034c0__step_b @ 0x8e1dc8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: state_sm_8034c0__action_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ftm__session_step, ftm_mngr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_8034c0__step_b
state_sm_8034c0__step_b:
	.global L_8e1dc8
L_8e1dc8:
	push_s blink
L_8e1dca:
	bl L_8c01e0
L_8e1dce:
	mov.f r14,r1
L_8e1dd2:
	mov_s r13,r0
L_8e1dd4:
	beq_s L_8e1df2
L_8e1dd6:
	add r15,r13,0xc
L_8e1dda:
	add r2,r14,0x10
L_8e1dde:
	bl.d L_8e4bc8
L_8e1de2:
	mov_s r1,r15
L_8e1de4:
	add r3,r14,0x8
L_8e1de8:
	mov_s r0,r13
L_8e1dea:
	mov_s r1,r15
L_8e1dec:
	bl.d L_8c2a30
L_8e1df0:
	mov_s r2,r14
	.global L_8e1df2
L_8e1df2:
	b L_8c024c
L_8e1df6:
	nop_s
