/* brd_if_multi_array__find_section @ 0x8caab8, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::find_section: Physical section verification failed, section_type=%d, section_offset_bytes=%d, section_size_bytes=%d
 * Зовут его: brd_if_multi_array__get_section_info_8ccb84
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, brd_if_multi_array, brd_multi_array__elem_bits, brd_section_info__reset, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__find_section
brd_if_multi_array__find_section:
	.global L_8caab8
L_8caab8:
	push_s blink
L_8caaba:
	bl L_8c01d8
L_8caabe:
	mov_s r16,r0
L_8caac0:
	mov_s r14,r1
L_8caac2:
	mov_s r13,r2
L_8caac4:
	asl_s r0,r1,0x2
L_8caac6:
	add1_s r0,r0,r0
L_8caac8:
	add_s r0,r0,0x8022c0
L_8caace:
	ld_s r3,[r0,0x4]
L_8caad0:
	ld_s r1,[r0,0x8]
L_8caad2:
	st.a r3,[sp,-0x8]
L_8caad6:
	st_s r1,[sp,0x4]
L_8caad8:
	mov r2,-0x1
L_8caadc:
	cmp_s r3,r2
L_8caade:
	cmp.eq r1,r2
L_8caae2:
	bne_s L_8caaee
L_8caae4:
	bl.d L_8c67a4
L_8caae8:
	mov_s r0,r13
L_8caaea:
	st_s r14,[r13]
L_8caaec:
	b_s L_8cab5a
	.global L_8caaee
L_8caaee:
	ld r1,[r16, 0x48]
L_8caaf2:
	ld_s r0,[r0]
L_8caaf4:
	add_s r1,r1,0x8
L_8caaf6:
	add3_s r1,r1,r0
L_8caaf8:
	ld_s r0,[r1,0x4]
L_8caafa:
	ld_s r15,[r1]
L_8caafc:
	asl r17,r0,0x3
L_8cab00:
	mov r4,sp
L_8cab04:
	mov_s r0,r16
L_8cab06:
	mov_s r1,r14
L_8cab08:
	mov_s r2,r15
L_8cab0a:
	bl.d L_8c630c
L_8cab0e:
	mov_s r3,r17
L_8cab10:
	brne_s r0,0,L_8cab2c
L_8cab12:
	mov_s r1,0x100ac10
L_8cab18:
	mov_s r13,0x0
L_8cab1a:
	mov_s r0,r13
L_8cab1c:
	mov_s r2,r14
L_8cab1e:
	mov_s r3,r15
L_8cab20:
	bl.d L_8dcd00
L_8cab24:
	mov r4,r17
L_8cab28:
	mov_s r0,r13
L_8cab2a:
	b_s L_8cab5c
	.global L_8cab2c
L_8cab2c:
	st_s r14,[r13]
L_8cab2e:
	st_s r15,[r13,0x8]
L_8cab30:
	st r17,[r13, 0xc]
L_8cab34:
	ld r0,[r16, 0x48]
L_8cab38:
	mov_s r1,r14
L_8cab3a:
	add_s r0,r0,0x8
L_8cab3c:
	add_s r15,r15,r0
L_8cab3e:
	mov_s r0,r16
L_8cab40:
	bl.d L_8cbae4
L_8cab44:
	ldb.a r2,[r15,0x8]
L_8cab48:
	st_s r0,[r13,0x4]
L_8cab4a:
	ldb_s r0,[r15]
L_8cab4c:
	stb_s r0,[r13,0x14]
L_8cab4e:
	ld_s r0,[r15]
L_8cab50:
	lsr_s r0,r0,0x14
L_8cab52:
	bmsk_s r0,r0,0x3
L_8cab54:
	stb_s r0,[r13,0x15]
L_8cab56:
	ld_s r0,[r15,0x4]
L_8cab58:
	st_s r0,[r13,0x10]
	.global L_8cab5a
L_8cab5a:
	mov_s r0,0x1
	.global L_8cab5c
L_8cab5c:
	b.d L_8c023c
L_8cab60:
	add_s sp,sp,0x8
L_8cab62:
	nop_s
