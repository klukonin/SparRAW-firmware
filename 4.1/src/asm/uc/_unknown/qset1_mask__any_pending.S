/* qset1_mask__any_pending @ 0x936b4c, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_tx__is_idle
 * Зовёт сам: __ld_r13_ret_uc, ucode_pm__rx_off_step
 */
	.section .text.qset1_mask__any_pending,"ax",@progbits
	.global qset1_mask__any_pending
qset1_mask__any_pending:
	.global L_936b4c
L_936b4c:
	push_s blink
L_936b4e:
	push_s r13
L_936b50:
	mov_s r13,r0
L_936b52:
	mov_s r0,0xf000001
L_936b58:
	mov_s r32,r0
L_936b5a:
	st.ab r0,[r25,0x4]
L_936b5e:
	bclr r25,r25,0xa
L_936b62:
	ld_s r0,[gp,-0x44]
L_936b64:
	and r0,r0,0xfffff0ff
L_936b6c:
	bset r1,r0,0x8
L_936b70:
	bset_s r1,r1,0x9
L_936b72:
	or r0,r0,0x1d000300
L_936b7a:
	st.as r1,[gp,-0x11]
L_936b7e:
	mov_s r32,r0
L_936b80:
	st.ab r0,[r25,0x4]
L_936b84:
	bclr r25,r25,0xa
L_936b88:
	nop_s
L_936b8a:
	nop_s
L_936b8c:
	nop_s
L_936b8e:
	bmsk.f 0x0,r41,0x1d
L_936b92:
	bne_s L_936b9e
L_936b94:
	mov_s r0,0x8009cc
L_936b9a:
	ld_s r0,[r0,0x10]
L_936b9c:
	brne_s r0,0,L_936ba0
	.global L_936b9e
L_936b9e:
	mov_s r13,0x1
	.global L_936ba0
L_936ba0:
	cmp_s r13,0x0
L_936ba2:
	bl.ne L_936cec
L_936ba6:
	b.d L_92028c
L_936baa:
	mov_s r0,r13
