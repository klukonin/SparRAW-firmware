/* abif__set_88a204_field @ 0x928cd8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__set_normal_mode
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global abif__set_88a204_field
abif__set_88a204_field:
	.global L_928cd8
L_928cd8:
	st.a r13,[sp,-0xc]
L_928cdc:
	st_s r14,[sp,0x8]
L_928cde:
	mov_s r14,r0
L_928ce0:
	bclr.f r0,r0,0x0
L_928ce4:
	st blink,[sp, 0x4]
L_928ce8:
	bne.d L_928d20
L_928cec:
	mov r13,r1
	.global L_928cf0
L_928cf0:
	bic.f 0x0,r13,0x3f
L_928cf4:
	bne L_928d30
	.global L_928cf8
L_928cf8:
	mov_s r0,0x88a000
L_928cfe:
	ld.as r1,[r0,0x81]
L_928d02:
	asl_s r13,r13
L_928d04:
	bclr_s r1,r1,0x0
L_928d06:
	or_s r1,r1,r14
L_928d08:
	bic r1,r1,0x7e
L_928d0c:
	or_s r13,r13,r1
L_928d0e:
	st.as r13,[r0,0x81]
L_928d12:
	ld blink,[sp, 0x4]
L_928d16:
	ld_s r14,[sp,0x8]
L_928d18:
	j.d [blink]
L_928d1c:
	ld.ab r13,[sp,0xc]
	.global L_928d20
L_928d20:
	mov r0,blink
L_928d24:
	bl.d L_926618
L_928d28:
	mov r1,0xad
L_928d2c:
	b L_928cf0
	.global L_928d30
L_928d30:
	mov r0,blink
L_928d34:
	bl.d L_926618
L_928d38:
	mov r1,0xae
L_928d3c:
	b_s L_928cf8
L_928d3e:
	nop_s
