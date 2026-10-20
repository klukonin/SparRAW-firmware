/* add_pbss_dmg_capinfo_list @ 0x8c2b50, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   add_pbss_dmg_capinfo_list() AID = %d
 *   AID = %d, was not added to PBSS sta list
 *   AID = %d, was added to PBSS sta list MAC ADDR: ADDR-%04X%08X
 *   VERIFY AID = %d, was added to PBSS sta list MAC ADDR: ADDR-%04X%08X
 * Зовут его: pbss_sta_list_update
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_log_emit3, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global add_pbss_dmg_capinfo_list
add_pbss_dmg_capinfo_list:
	.global L_8c2b50
L_8c2b50:
	push_s blink
L_8c2b52:
	bl L_8c01e4
L_8c2b56:
	mov_s r13,r0
L_8c2b58:
	mov_s r14,r1
L_8c2b5a:
	mov_s r1,0x100c55c
L_8c2b60:
	mov_s r0,0x2b
L_8c2b62:
	bl.d L_8dcc10
L_8c2b66:
	ldb_s r2,[r14,0x6]
L_8c2b68:
	add3 r0,r13,0xc
L_8c2b6c:
	ldb_s r2,[r14,0x6]
L_8c2b6e:
	mul64 r2,0x11
L_8c2b72:
	add_s r0,r0,mlo
L_8c2b74:
	ldb_s r1,[r0,0x15]
L_8c2b76:
	brne r2,r1,L_8c2b8a
L_8c2b7a:
	mov_s r1,0x100c584
L_8c2b80:
	bl.d L_8dcc10
L_8c2b84:
	mov_s r0,0x2b
L_8c2b86:
	mov_s r0,0x0
L_8c2b88:
	b_s L_8c2c0e
	.global L_8c2b8a
L_8c2b8a:
	add_s r0,r0,0xf
L_8c2b8c:
	mov_s r1,r14
L_8c2b8e:
	bl.d L_8c0380
L_8c2b92:
	mov_s r2,0x11
L_8c2b94:
	ldb_s r0,[r14,0x5]
L_8c2b96:
	ldb_s r3,[r14,0x4]
L_8c2b98:
	asl_s r0,r0,0x8
L_8c2b9a:
	or_s r3,r3,r0
L_8c2b9c:
	ldb_s r0,[r14,0x1]
L_8c2b9e:
	ldb r4,[r14]
L_8c2ba2:
	asl_s r0,r0,0x8
L_8c2ba4:
	or r4,r4,r0
L_8c2ba8:
	ldb_s r0,[r14,0x2]
L_8c2baa:
	mov_s r1,0x100c5b0
L_8c2bb0:
	asl_s r0,r0,0x10
L_8c2bb2:
	or r4,r4,r0
L_8c2bb6:
	ldb_s r0,[r14,0x3]
L_8c2bb8:
	asl_s r0,r0,0x18
L_8c2bba:
	or r4,r4,r0
L_8c2bbe:
	mov_s r0,0x2b
L_8c2bc0:
	bl.d L_8dcd00
L_8c2bc4:
	ldb_s r2,[r14,0x6]
L_8c2bc6:
	ldb_s r0,[r14,0x6]
L_8c2bc8:
	mov_s r1,0x100c5f0
L_8c2bce:
	mul64 r0,0x11
L_8c2bd2:
	add_s r13,r13,mlo
L_8c2bd4:
	ldb r0,[r13, 0x74]
L_8c2bd8:
	ldb r3,[r13, 0x73]
L_8c2bdc:
	asl_s r0,r0,0x8
L_8c2bde:
	or_s r3,r3,r0
L_8c2be0:
	ldb r0,[r13, 0x70]
L_8c2be4:
	ldb r4,[r13, 0x6f]
L_8c2be8:
	asl_s r0,r0,0x8
L_8c2bea:
	or r4,r4,r0
L_8c2bee:
	ldb r0,[r13, 0x71]
L_8c2bf2:
	asl_s r0,r0,0x10
L_8c2bf4:
	or r4,r4,r0
L_8c2bf8:
	ldb r0,[r13, 0x72]
L_8c2bfc:
	asl_s r0,r0,0x18
L_8c2bfe:
	or r4,r4,r0
L_8c2c02:
	mov_s r0,0x2b
L_8c2c04:
	bl.d L_8dcd00
L_8c2c08:
	ldb r2,[r13, 0x75]
L_8c2c0c:
	mov_s r0,0x1
	.global L_8c2c0e
L_8c2c0e:
	b L_8c0254
L_8c2c12:
	nop_s
