/* hwd_abif__uses_rgf_889480_8cf958 @ 0x8cf958, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf__rf_lo_setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__uses_rgf_889480_8cf958
hwd_abif__uses_rgf_889480_8cf958:
	.global L_8cf958
L_8cf958:
	push_s blink
L_8cf95a:
	bl L_8c01e4
L_8cf95e:
	mov.f r13,r0
L_8cf962:
	mov.ne r13,0x1
L_8cf966:
	cmp_s r0,0x0
L_8cf968:
	mov_s r14,0x1
L_8cf96a:
	sub_s.ne r14,r14,r14
L_8cf96c:
	mov_s r12,r14
L_8cf96e:
	bic.f r12,r12,-0xff
L_8cf972:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cf974:
	bne_s L_8cf99a
	.global L_8cf976
L_8cf976:
	bic.f 0x0,r13,0xf
L_8cf97a:
	bne_s L_8cf9a4
	.global L_8cf97c
L_8cf97c:
	mov_s r0,0x889480
L_8cf982:
	ld_s r2,[r0,0x24]
L_8cf984:
	asl_s r14,r14,0xf
L_8cf986:
	mov_s r1,0xffff07ff
L_8cf98c:
	and_s r1,r1,r2
L_8cf98e:
	or_s r14,r14,r1
L_8cf990:
	asl_s r13,r13,0xb
L_8cf992:
	or_s r13,r13,r14
L_8cf994:
	st_s r13,[r0,0x24]
L_8cf996:
	b L_8c0254
	.global L_8cf99a
L_8cf99a:
	mov_s r0,blink
L_8cf99c:
	bl.d L_8c9b28
L_8cf9a0:
	mov_s r1,0xad
L_8cf9a2:
	b_s L_8cf976
	.global L_8cf9a4
L_8cf9a4:
	mov_s r0,blink
L_8cf9a6:
	bl.d L_8c9b28
L_8cf9aa:
	mov_s r1,0xae
L_8cf9ac:
	b_s L_8cf97c
L_8cf9ae:
	nop_s
