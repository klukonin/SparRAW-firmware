/* mbox__drain_operational @ 0x8e378c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sysassert__wmi_lock_notice
 * Зовёт сам: __ld_r13_to_r13_ret, fw_mailbox__has_pending, mbox__consume_one, tx_api__ctx_8041f0
 * Глобалы (через gp): 0x800404
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mbox__drain_operational
mbox__drain_operational:
	.global L_8e378c
L_8e378c:
	push_s blink
L_8e378e:
	bl.d L_8d9f7c
L_8e3792:
	push_s r13
L_8e3794:
	mov_s r13,r0
L_8e3796:
	mov_s r0,0x1
L_8e3798:
	st.as r0,[gp,0xa0]
L_8e379c:
	b_s L_8e37ac
	.global L_8e379e
L_8e379e:
	bl.d L_8e3764
L_8e37a2:
	mov_s r0,r13
L_8e37a4:
	ld_s r0,[r13,0x44]
L_8e37a6:
	ld_s r1,[r0,0xc]
L_8e37a8:
	jl_s.d [r1]
L_8e37aa:
	mov_s r0,r13
	.global L_8e37ac
L_8e37ac:
	bl.d L_8c37ec
L_8e37b0:
	mov_s r0,r13
L_8e37b2:
	brne_s r0,0,L_8e379e
L_8e37b4:
	ld_s r0,[r13,0x44]
L_8e37b6:
	ld_s r1,[r0,0x8]
L_8e37b8:
	jl_s.d [r1]
L_8e37ba:
	mov_s r0,r13
L_8e37bc:
	mov_s r0,0x0
L_8e37be:
	b.d L_8c025c
L_8e37c2:
	st.as r0,[gp,0xa0]
L_8e37c6:
	nop_s
