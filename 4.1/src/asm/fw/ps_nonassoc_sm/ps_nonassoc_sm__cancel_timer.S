/* ps_nonassoc_sm__cancel_timer @ 0x8dd1a0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ps_nonassoc_sm.cpp
 * Зовут его: ps_nonassoc_sm__rearm_timer
 * Зовёт сам: fw_sysassert_fatal, u_schd__cancel
 */
	.section .text.ps_nonassoc_sm__cancel_timer,"ax",@progbits
	.global ps_nonassoc_sm__cancel_timer
ps_nonassoc_sm__cancel_timer:
	.global L_8dd1a0
L_8dd1a0:
	push_s blink
L_8dd1a2:
	ld_s r0,[gp,-0x54]
L_8dd1a4:
	breq_s r0,0,L_8dd1b2
L_8dd1a6:
	bl L_8c7794
L_8dd1aa:
	mov_s r0,0x0
L_8dd1ac:
	st.as r0,[gp,-0x15]
L_8dd1b0:
	b_s L_8dd1c6
	.global L_8dd1b2
L_8dd1b2:
	mov_s r0,blink
L_8dd1b4:
	mov_s r2,0x10026d8
L_8dd1ba:
	mov_s r1,0x2110
L_8dd1c0:
	bl.d L_8c82c0
L_8dd1c4:
	mov_s r3,0x7f
	.global L_8dd1c6
L_8dd1c6:
	pop_s blink
