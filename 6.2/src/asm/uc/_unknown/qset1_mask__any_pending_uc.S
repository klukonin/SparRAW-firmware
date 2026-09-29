/* qset1_mask__any_pending_uc @ 0x93c678, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_tx__is_idle
 * Зовёт сам: __ld_r13_to_r13_ret, rx__enter_listen_mode
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global qset1_mask__any_pending_uc
qset1_mask__any_pending_uc:
	.global L_93c678
L_93c678:
	push_s blink
L_93c67a:
	push_s r13
L_93c67c:
	mov_s r13,r0
L_93c67e:
	mov_s r0,0xf000001
L_93c684:
	mov_s r32,r0
L_93c686:
	st.ab r0,[r25,0x4]
L_93c68a:
	bclr r25,r25,0xa
L_93c68e:
	ld_s r0,[gp,-0x44]
L_93c690:
	and r0,r0,0xfffff0ff
L_93c698:
	bset r1,r0,0x8
L_93c69c:
	bset_s r1,r1,0x9
L_93c69e:
	or r0,r0,0x1d000300
L_93c6a6:
	st.as r1,[gp,-0x11]
L_93c6aa:
	mov_s r32,r0
L_93c6ac:
	st.ab r0,[r25,0x4]
L_93c6b0:
	bclr r25,r25,0xa
L_93c6b4:
	nop_s
L_93c6b6:
	nop_s
L_93c6b8:
	nop_s
L_93c6ba:
	bmsk.f 0x0,r41,0x1d
L_93c6be:
	bne_s L_93c6ca
L_93c6c0:
	mov_s r0,0x8014a4
L_93c6c6:
	ld_s r0,[r0,0x10]
L_93c6c8:
	brne_s r0,0,L_93c6cc
	.global L_93c6ca
L_93c6ca:
	mov_s r13,0x1
	.global L_93c6cc
L_93c6cc:
	cmp_s r13,0x0
L_93c6ce:
	bl.ne L_93c818
L_93c6d2:
	b.d L_9202ac
L_93c6d6:
	mov_s r0,r13
