/* buf__check_bounds @ 0x92ac80, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: memset_uc
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global buf__check_bounds
buf__check_bounds:
	.global L_92ac80
L_92ac80:
	st.a r13,[sp,-0xc]
L_92ac84:
	ld_s r13,[r0]
L_92ac86:
	st_s r14,[sp,0x8]
L_92ac88:
	ld_s r1,[r0,0x8]
L_92ac8a:
	add_s r13,r13,0x8
L_92ac8c:
	st blink,[sp, 0x4]
L_92ac90:
	brlo.d r1,r13,L_92aca8
L_92ac94:
	mov r14,r0
	.global L_92ac98
L_92ac98:
	brne r13,r1,L_92acbc
L_92ac9c:
	ld r0,[r14, 0x4]
L_92aca0:
	b.d L_92acc0
L_92aca4:
	st r0,[r14]
	.global L_92aca8
L_92aca8:
	mov r0,blink
L_92acac:
	bl.d L_926618
L_92acb0:
	mov r1,0xcc
L_92acb4:
	b.d L_92ac98
L_92acb8:
	ld r1,[r14, 0x8]
	.global L_92acbc
L_92acbc:
	st r13,[r14]
	.global L_92acc0
L_92acc0:
	ld blink,[sp, 0x4]
L_92acc4:
	ld_s r14,[sp,0x8]
L_92acc6:
	j_s.d [blink]
L_92acc8:
	ld.ab r13,[sp,0xc]
