/* ese__slot_table_add @ 0x8e1d38, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ese__alloc_to_slot, schedule__build_allocation_entry
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ese__slot_table_add
ese__slot_table_add:
	.global L_8e1d38
L_8e1d38:
	push_s blink
L_8e1d3a:
	bl L_8c01dc
L_8e1d3e:
	mov_s r13,r0
L_8e1d40:
	ld_s r0,[r0,0x4]
L_8e1d42:
	ldb_s r0,[r0,0x1]
L_8e1d44:
	brge.d r0,0x3,L_8e1d6a
L_8e1d48:
	mov_s r16,r1
	.global L_8e1d4a
L_8e1d4a:
	ld_s r1,[r13,0x4]
L_8e1d4c:
	ldb_s r0,[r1,0x1]
L_8e1d4e:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8e1d50:
	add1_s r0,r0,r0
L_8e1d52:
	add_s r0,r0,r1
L_8e1d54:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8e1d56:
	mov_s r1,r16
L_8e1d58:
	bl.d L_8c0380
L_8e1d5c:
	mov_s r2,0xc
L_8e1d5e:
	ld_s r1,[r13,0x4]
L_8e1d60:
	ldb_s r0,[r1,0x1]
L_8e1d62:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e1d64:
	b.d L_8c0244
L_8e1d68:
	stb_s r0,[r1,0x1]
	.global L_8e1d6a
L_8e1d6a:
	mov_s r0,blink
L_8e1d6c:
	mov_s r1,0x11bb
L_8e1d72:
	bl L_8c9b28
L_8e1d76:
	b_s L_8e1d4a
