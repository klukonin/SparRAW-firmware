/* brd_if_multi_array__find_section @ 0x8c8dc8, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::find_section: Physical section verification failed, section_type=%d, section_offset_bytes=%d, section_size_bytes=%d
 * Зовут его: brd_if_multi_array__get_section_info
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, brd_if__clear_section_info, brd_if__section_bit_index, brd_if_multi_array__check_physical_section_validity, fw_log__emit3
 */
	.section .text.brd_if_multi_array__find_section,"ax",@progbits
	.global brd_if_multi_array__find_section
brd_if_multi_array__find_section:
	.global L_8c8dc8
L_8c8dc8:
	push_s blink
L_8c8dca:
	bl L_8c02b8
L_8c8dce:
	mov_s r15,r0
L_8c8dd0:
	mov_s r14,r1
L_8c8dd2:
	mov_s r13,r2
L_8c8dd4:
	asl_s r0,r1,0x2
L_8c8dd6:
	add1_s r0,r0,r0
L_8c8dd8:
	add_s r0,r0,0x801d98
L_8c8dde:
	ld_s r3,[r0,0x4]
L_8c8de0:
	ld_s r1,[r0,0x8]
L_8c8de2:
	st.a r3,[sp,-0x8]
L_8c8de6:
	st_s r1,[sp,0x4]
L_8c8de8:
	mov r2,-0x1
L_8c8dec:
	cmp_s r3,r2
L_8c8dee:
	cmp.eq r1,r2
L_8c8df2:
	bne_s L_8c8dfe
L_8c8df4:
	bl.d L_8c5a20
L_8c8df8:
	mov_s r0,r13
L_8c8dfa:
	st_s r14,[r13]
L_8c8dfc:
	b_s L_8c8e5c
	.global L_8c8dfe
L_8c8dfe:
	ld_s r1,[r15,0x4]
L_8c8e00:
	ld_s r0,[r0]
L_8c8e02:
	add_s r1,r1,0x8
L_8c8e04:
	add3_s r1,r1,r0
L_8c8e06:
	ld_s r0,[r1,0x4]
L_8c8e08:
	ld r17,[r1]
L_8c8e0c:
	asl r16,r0,0x3
L_8c8e10:
	mov r4,sp
L_8c8e14:
	mov_s r0,r15
L_8c8e16:
	mov_s r1,r14
L_8c8e18:
	mov_s r2,r17
L_8c8e1a:
	bl.d L_8c5614
L_8c8e1e:
	mov_s r3,r16
L_8c8e20:
	brne_s r0,0,L_8c8e40
L_8c8e22:
	mov_s r2,0x100970c
L_8c8e28:
	mov_s r13,0x0
L_8c8e2a:
	mov_s r0,r13
L_8c8e2c:
	mov_s r1,r13
L_8c8e2e:
	mov_s r3,r14
L_8c8e30:
	mov r4,r17
L_8c8e34:
	bl.d L_8ee034
L_8c8e38:
	mov r5,r16
L_8c8e3c:
	mov_s r0,r13
L_8c8e3e:
	b_s L_8c8e5e
	.global L_8c8e40
L_8c8e40:
	st_s r14,[r13]
L_8c8e42:
	st r17,[r13, 0x8]
L_8c8e46:
	st r16,[r13, 0xc]
L_8c8e4a:
	ld_s r0,[r15,0x4]
L_8c8e4c:
	add_s r0,r0,0x10
L_8c8e4e:
	ldb r2,[r0,r17]
L_8c8e52:
	mov_s r0,r15
L_8c8e54:
	bl.d L_8c9a6c
L_8c8e58:
	mov_s r1,r14
L_8c8e5a:
	st_s r0,[r13,0x4]
	.global L_8c8e5c
L_8c8e5c:
	mov_s r0,0x1
	.global L_8c8e5e
L_8c8e5e:
	b.d L_8c031c
L_8c8e62:
	add_s sp,sp,0x8
