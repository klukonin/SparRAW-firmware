/* hwd_abif__rfc_divider_restart_uc @ 0x928c78, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_rfc_read_rgf_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rfc_divider_restart_uc
hwd_abif__rfc_divider_restart_uc:
	.global L_928c78
L_928c78:
	push_s r13
L_928c7a:
	mov r6,0x889000
L_928c82:
	ld.as r3,[r6,0xe5]
L_928c86:
	mov_s r13,blink
L_928c88:
	bclr_s r3,r3,0x0
L_928c8a:
	st.as r3,[r6,0xe5]
L_928c8e:
	mov r5,0x889800
L_928c96:
	ld.as r1,[r5,-0xf9]
L_928c9a:
	mov r7,0x50
L_928c9e:
	bset_s r1,r1,0x3
L_928ca0:
	st.as r1,[r5,-0xf9]
L_928ca4:
	ld.as r0,[r5,-0xf9]
L_928ca8:
	bclr r0,r0,0x3
L_928cac:
	st.as r0,[r5,-0xf9]
L_928cb0:
	mov lp_count,r7
L_928cb4:
	nop_s
L_928cb6:
	lp L_928cbe
L_928cba:
	nop_s
L_928cbc:
	nop_s
	.global L_928cbe
L_928cbe:
	mov r4,0x889000
L_928cc6:
	ld.as r2,[r4,0xe5]
L_928cca:
	mov_s blink,r13
L_928ccc:
	bset_s r2,r2,0x0
L_928cce:
	st.as r2,[r4,0xe5]
L_928cd2:
	j.d [blink]
L_928cd6:
	pop_s r13
