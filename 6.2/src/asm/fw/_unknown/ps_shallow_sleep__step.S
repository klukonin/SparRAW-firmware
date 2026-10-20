/* ps_shallow_sleep__step @ 0x8e74a0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_shallow_sleep_ntf_evt
 * Зовёт сам: conn_main_sm__action_step, sys_state__broadcast
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_shallow_sleep__step
ps_shallow_sleep__step:
	.global L_8e74a0
L_8e74a0:
	push_s blink
L_8e74a2:
	breq_s r0,0,L_8e74b4
L_8e74a4:
	mov_s r0,0x1
L_8e74a6:
	st.as r0,[gp,-0xc]
L_8e74aa:
	bl.d L_8e8a14
L_8e74ae:
	mov_s r0,0x14
	.global L_8e74b0
L_8e74b0:
	pop_s blink
L_8e74b2:
	j_s [blink]
	.global L_8e74b4
L_8e74b4:
	mov_s r1,0x0
L_8e74b6:
	st.as r1,[gp,-0xc]
L_8e74ba:
	bl.d L_8e8a14
L_8e74be:
	mov_s r0,0x15
L_8e74c0:
	ld_s r0,[gp,-0x70]
L_8e74c2:
	brne r0,0x1,L_8e74d2
L_8e74c6:
	ld_s r0,[gp,-0xcc]
L_8e74c8:
	mov_s r1,0x2
L_8e74ca:
	bl.d L_8c9300
L_8e74ce:
	mov_s r2,0x3
L_8e74d0:
	b_s L_8e74b0
	.global L_8e74d2
L_8e74d2:
	b_s L_8e74b0
