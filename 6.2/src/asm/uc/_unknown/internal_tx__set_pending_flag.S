/* internal_tx__set_pending_flag @ 0x92bbd8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__check_idle
 * Зовёт сам: mac__publish_masks
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__set_pending_flag
internal_tx__set_pending_flag:
	.global L_92bbd8
L_92bbd8:
	push_s blink
L_92bbda:
	ld_s r0,[gp,-0x7c]
L_92bbdc:
	bset_s r0,r0,0x7
L_92bbde:
	bl.d L_93d0ac
L_92bbe2:
	st.as r0,[gp,-0x1f]
L_92bbe6:
	ld_s r0,[gp,-0x60]
L_92bbe8:
	mov_s r1,0x886f00
L_92bbee:
	bset_s r0,r0,0x1f
L_92bbf0:
	st.as r0,[gp,-0x18]
L_92bbf4:
	st_s r0,[r1,0x5c]
L_92bbf6:
	pop_s blink
L_92bbf8:
	j_s [blink]
L_92bbfa:
	nop_s
