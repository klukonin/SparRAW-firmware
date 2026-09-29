/* hwd_phy__uses_rgf_883000 @ 0x929960, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__set_normal_mode
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__uses_rgf_883000
hwd_phy__uses_rgf_883000:
	.global L_929960
L_929960:
	st.a r13,[sp,-0x8]
L_929964:
	mov_s r13,r0
L_929966:
	bclr.f r0,r0,0x0
L_92996a:
	st_s r14,[sp,0x4]
L_92996c:
	bne.d L_92998c
L_929970:
	mov r14,blink
	.global L_929974
L_929974:
	mov_s r1,0x883000
L_92997a:
	ld_s r0,[r1,0x10]
L_92997c:
	mov_s blink,r14
L_92997e:
	bclr_s r0,r0,0x0
L_929980:
	or_s r13,r13,r0
L_929982:
	st_s r13,[r1,0x10]
L_929984:
	ld_s r14,[sp,0x4]
L_929986:
	j_s.d [blink]
L_929988:
	ld.ab r13,[sp,0x8]
	.global L_92998c
L_92998c:
	mov r0,blink
L_929990:
	bl.d L_926618
L_929994:
	mov r1,0xac
L_929998:
	b_s L_929974
L_92999a:
	nop_s
