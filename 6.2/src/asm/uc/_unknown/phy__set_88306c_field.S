/* phy__set_88306c_field @ 0x929cac, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_mode__configure
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global phy__set_88306c_field
phy__set_88306c_field:
	.global L_929cac
L_929cac:
	st.a r13,[sp,-0x8]
L_929cb0:
	mov_s r13,r0
L_929cb2:
	bic.f r0,r0,0x3f
L_929cb6:
	st_s r14,[sp,0x4]
L_929cb8:
	bne.d L_929cdc
L_929cbc:
	mov r14,blink
	.global L_929cc0
L_929cc0:
	mov_s r1,0x883000
L_929cc6:
	ld_s r0,[r1,0x6c]
L_929cc8:
	mov_s blink,r14
L_929cca:
	bic r0,r0,0x3f
L_929cce:
	or_s r0,r0,r13
L_929cd0:
	st_s r0,[r1,0x6c]
L_929cd2:
	ld_s r14,[sp,0x4]
L_929cd4:
	j.d [blink]
L_929cd8:
	ld.ab r13,[sp,0x8]
	.global L_929cdc
L_929cdc:
	mov r0,blink
L_929ce0:
	bl.d L_926618
L_929ce4:
	mov r1,0xac
L_929ce8:
	b_s L_929cc0
L_929cea:
	nop_s
