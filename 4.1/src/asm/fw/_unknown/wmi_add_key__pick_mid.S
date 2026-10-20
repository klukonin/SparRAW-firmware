/* wmi_add_key__pick_mid @ 0x8c9ab8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WMI_ADD_CIPHER_KEY_CMD
 * Зовёт сам: __ld_r13_ret, frag_8ca038, mid_list__count_free
 */
	.section .text.wmi_add_key__pick_mid,"ax",@progbits
	.global wmi_add_key__pick_mid
wmi_add_key__pick_mid:
	.global L_8c9ab8
L_8c9ab8:
	push_s blink
L_8c9aba:
	push_s r13
L_8c9abc:
	mov_s r13,r0
L_8c9abe:
	ld_s r0,[r0,0x18]
L_8c9ac0:
	cmp_s r0,0x0
L_8c9ac2:
	mov_s r0,0x1
L_8c9ac4:
	sub_s.ne r0,r0,r0
L_8c9ac6:
	extb.f 0x0,r0
L_8c9aca:
	bne_s L_8c9ad4
L_8c9acc:
	bl.d L_8ca464
L_8c9ad0:
	mov_s r0,r13
L_8c9ad2:
	brne_s r0,0,L_8c9ad8
	.global L_8c9ad4
L_8c9ad4:
	mov_s r0,0x0
L_8c9ad6:
	b_s L_8c9ade
	.global L_8c9ad8
L_8c9ad8:
	bl.d L_8ca038
L_8c9adc:
	mov_s r0,r13
	.global L_8c9ade
L_8c9ade:
	b L_8c033c
L_8c9ae2:
	nop_s
