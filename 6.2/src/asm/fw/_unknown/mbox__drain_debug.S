/* mbox__drain_debug @ 0x8e37c8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sysassert__wmi_lock_notice
 * Зовёт сам: __ld_r13_to_r13_ret, debug_mbox__get_or_init, fw_mailbox__has_pending, mbox__consume_one
 * Глобалы (через gp): 0x800330
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mbox__drain_debug
mbox__drain_debug:
	.global L_8e37c8
L_8e37c8:
	push_s blink
L_8e37ca:
	bl.d L_8d9f9c
L_8e37ce:
	push_s r13
L_8e37d0:
	mov_s r13,r0
L_8e37d2:
	mov_s r0,0x1
L_8e37d4:
	st.as r0,[gp,0x6b]
L_8e37d8:
	b_s L_8e37e0
	.global L_8e37da
L_8e37da:
	bl.d L_8e3764
L_8e37de:
	mov_s r0,r13
	.global L_8e37e0
L_8e37e0:
	bl.d L_8c37ec
L_8e37e4:
	mov_s r0,r13
L_8e37e6:
	brne_s r0,0,L_8e37da
L_8e37e8:
	ld_s r0,[r13,0x44]
L_8e37ea:
	ld_s r1,[r0,0x8]
L_8e37ec:
	jl_s.d [r1]
L_8e37ee:
	mov_s r0,r13
L_8e37f0:
	mov_s r0,0x0
L_8e37f2:
	b.d L_8c025c
L_8e37f6:
	st.as r0,[gp,0x6b]
L_8e37fa:
	nop_s
