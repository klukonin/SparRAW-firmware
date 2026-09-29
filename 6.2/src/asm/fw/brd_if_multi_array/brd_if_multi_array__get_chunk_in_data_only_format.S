/* brd_if_multi_array__get_chunk_in_data_only_format @ 0x8cbd80, 288 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_chunk_in_data_only_format: chunk data overflows its block boundaries, chunk_idx=%d, brd_block_end_addr=%d, p_brd_data_value=%d
 *   brd_if_multi_array::get_chunk_in_data_only_format: board_file_start_address=%d, chunk_start_addr=%d, num_actual_values=%d
 * Зовут его: brd_if_multi_array__get_chunk_8cbbc4
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, brd_if__block_info, brd_if__chunk_offset, brd_if__parse_chunk_header, brd_if_multi_array__get_chunk, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__get_chunk_in_data_only_format
brd_if_multi_array__get_chunk_in_data_only_format:
	.global L_8cbd80
L_8cbd80:
	push_s blink
L_8cbd82:
	bl L_8c01c4
L_8cbd86:
	mov_s r18,r0
L_8cbd88:
	mov_s r14,r1
L_8cbd8a:
	mov_s r17,r2
L_8cbd8c:
	st.a r3,[sp,-0xc]
L_8cbd90:
	mov r19,r4
L_8cbd94:
	ld_s r1,[r0,0x48]
L_8cbd96:
	mov r21,r6
L_8cbd9a:
	ld_s r0,[r14,0x8]
L_8cbd9c:
	add_s r1,r1,0x8
L_8cbd9e:
	add_s r0,r0,r1
L_8cbda0:
	add r20,r0,0x8
L_8cbda4:
	mov_s r13,0x0
L_8cbda6:
	stb_s r13,[sp,0x4]
L_8cbda8:
	ld r0,[r20]
L_8cbdac:
	mov_s r15,r5
L_8cbdae:
	lsr r4,r0,0x1a
L_8cbdb2:
	add r5,sp,0x4
L_8cbdb6:
	mov_s r0,r18
L_8cbdb8:
	mov_s r1,r3
L_8cbdba:
	mov_s r2,r15
L_8cbdbc:
	bl.d L_8c5410
L_8cbdc0:
	ld_s r3,[r14,0x10]
L_8cbdc2:
	mov_s r14,r0
L_8cbdc4:
	st_s r13,[sp,0x8]
L_8cbdc6:
	ld r0,[r20]
L_8cbdca:
	add r5,sp,0x8
L_8cbdce:
	lsr r4,r0,0x18
L_8cbdd2:
	mov_s r0,r18
L_8cbdd4:
	mov_s r1,r17
L_8cbdd6:
	ld_s r2,[sp,0x0]
L_8cbdd8:
	mov_s r3,r15
L_8cbdda:
	bl.d L_8ca760
L_8cbdde:
	bmsk r4,r4,0x1
L_8cbde2:
	mov_s r16,r0
L_8cbde4:
	mov_s r11,r0
L_8cbde6:
	b_s L_8cbe3e
	.global L_8cbde8
L_8cbde8:
	ldb_s r15,[sp,0x4]
L_8cbdea:
	brhs r15,0x6,L_8cbe3e
L_8cbdee:
	rsub r0,r15,0x6
	.global L_8cbdf2
L_8cbdf2:
	mov_s r22,r0
L_8cbdf4:
	ld r0,[r20]
L_8cbdf8:
	lsr_s r0,r0,0x1a
L_8cbdfa:
	bbit0 r0,r15,L_8cbe32
L_8cbdfe:
	add3 r0,r19,r13
L_8cbe02:
	st_s r14,[r0]
L_8cbe04:
	ld r3,[r11]
L_8cbe08:
	cmp r21,0x0
L_8cbe0c:
	st_s r3,[r0,0x4]
L_8cbe0e:
	mov.ne r0,r18
L_8cbe12:
	mov.ne r1,r11
L_8cbe16:
	mov.ne r2,r14
L_8cbe1a:
	mov.ne r4,0x1
L_8cbe1e:
	bl.ne.d L_8c7444
L_8cbe22:
	mov.ne r5,r21
L_8cbe26:
	ld_s r0,[sp,0x8]
L_8cbe28:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cbe2a:
	brhs.d r13,r0,L_8cbe3e
L_8cbe2e:
	add r11,r11,0x4
	.global L_8cbe32
L_8cbe32:
	sub r0,r22,0x1
L_8cbe36:
	/* add_s r14,0x4 */
	.byte 0x04,0xe6
L_8cbe38:
	brhs.d r0,0x1,L_8cbdf2
L_8cbe3c:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8cbe3e
L_8cbe3e:
	ld_s r0,[sp,0x8]
L_8cbe40:
	brlo r13,r0,L_8cbde8
L_8cbe44:
	ld r0,[r18, 0x48]
L_8cbe48:
	ld r1,[r17, 0x10]
L_8cbe4c:
	add_s r0,r0,0x8
L_8cbe4e:
	ld r3,[r17, 0x14]
L_8cbe52:
	add_s r0,r0,r1
L_8cbe54:
	add_s r3,r3,r0
L_8cbe56:
	brhs r3,r11,L_8cbe98
L_8cbe5a:
	ld_s r2,[sp,0x0]
L_8cbe5c:
	mov_s r1,0x100b088
L_8cbe62:
	mov_s r0,0x0
L_8cbe64:
	bl.d L_8dcd00
L_8cbe68:
	mov r4,r11
L_8cbe6c:
	ld r2,[r18, 0x48]
L_8cbe70:
	mov_s r1,0x100b120
L_8cbe76:
	add_s r2,r2,0x8
L_8cbe78:
	ld r4,[sp, 0x8]
L_8cbe7c:
	mov_s r0,0x0
L_8cbe7e:
	bl.d L_8dcd00
L_8cbe82:
	mov_s r3,r16
L_8cbe84:
	mov_s r0,r17
L_8cbe86:
	bl.d L_8e0fa0
L_8cbe8a:
	mov_s r1,0x0
L_8cbe8c:
	mov_s r0,blink
L_8cbe8e:
	mov_s r1,0x1351
L_8cbe94:
	bl L_8c9b28
	.global L_8cbe98
L_8cbe98:
	ld_s r0,[sp,0x8]
L_8cbe9a:
	b.d L_8c0214
L_8cbe9e:
	add_s sp,sp,0xc
