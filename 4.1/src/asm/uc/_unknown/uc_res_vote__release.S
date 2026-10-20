/* uc_res_vote__release @ 0x928df4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__clear_pending
 * Зовёт сам: __ld_r13_ret_uc, bi_tx__check_idle_and_start, mac__publish_masks
 * Глобалы (через gp): 0x800554
 */
	.section .text.uc_res_vote__release,"ax",@progbits
	.global uc_res_vote__release
uc_res_vote__release:
	.global L_928df4
L_928df4:
	push_s blink
L_928df6:
	push_s r13
L_928df8:
	lr r13,[0xa]
L_928dfc:
	bclr r1,r13,0x1
L_928e00:
	flag r1
L_928e04:
	ld.as r1,[gp,0xb]
L_928e08:
	bclr.f r1,r1,r0
L_928e0c:
	st.as r1,[gp,0xb]
L_928e10:
	bne_s L_928e26
L_928e12:
	ld_s r0,[gp,-0x74]
L_928e14:
	or r0,r0,0x70
L_928e18:
	bl.d L_9373b0
L_928e1c:
	st.as r0,[gp,-0x1d]
L_928e20:
	bl.d L_931a78
L_928e24:
	mov_s r0,0x2
	.global L_928e26
L_928e26:
	lr r0,[0xa]
L_928e2a:
	bic r13,r13,-0x3
L_928e2e:
	or_s r13,r13,r0
L_928e30:
	flag r13
L_928e34:
	b L_92028c
