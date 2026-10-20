/* bi__after_enter_aw @ 0x92b798, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_sm__action_935a94
 * Зовёт сам: aw__start_window, bi__state_from_g800600, uc_read_tsf_lo, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi__after_enter_aw
bi__after_enter_aw:
	.global L_92b798
L_92b798:
	st.a r13,[sp,-0x8]
L_92b79c:
	st blink,[sp, 0x4]
L_92b7a0:
	bl.d L_9282b4
L_92b7a4:
	mov r13,r0
L_92b7a8:
	brne.d r0,0x2,L_92b7cc
L_92b7ac:
	st r0,[r13, 0x38]
	.global L_92b7b0
L_92b7b0:
	bl L_9364c8
L_92b7b4:
	mov r1,r0
L_92b7b8:
	bl.d L_935ae4
L_92b7bc:
	add r0,r13,0x24
L_92b7c0:
	ld blink,[sp, 0x4]
L_92b7c4:
	j.d [blink]
L_92b7c8:
	ld.ab r13,[sp,0x8]
	.global L_92b7cc
L_92b7cc:
	mov r0,blink
L_92b7d0:
	bl.d L_926618
L_92b7d4:
	mov r1,0x64
L_92b7d8:
	b_s L_92b7b0
L_92b7da:
	nop_s
