/* set_old_wilocity_vs @ 0x8e1bb4, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   set_old_wilocity_vs = flags %x srv_id_1 = %x srv_id_2 = %x
 * Зовут его: mlme_sm__assoc_req_handle, set_vendor_specific_version
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit3, memcpy_fw
 */
	.section .text.set_old_wilocity_vs,"ax",@progbits
	.global set_old_wilocity_vs
set_old_wilocity_vs:
	.global L_8e1bb4
L_8e1bb4:
	push_s blink
L_8e1bb6:
	bl L_8c02c0
L_8e1bba:
	mov.f r14,r1
L_8e1bbe:
	mov_s r1,r2
L_8e1bc0:
	mov_s r2,0x100b254
L_8e1bc6:
	add3 r13,r0,0x20
L_8e1bca:
	bne_s L_8e1c04
L_8e1bcc:
	ld_s r0,[gp,-0xc]
L_8e1bce:
	mov_s r15,0xaa
L_8e1bd0:
	stb_s r15,[r13,0xf]
L_8e1bd2:
	mov_s r14,0x0
L_8e1bd4:
	mov_s r15,0x6c
L_8e1bd6:
	stb_s r14,[r13,0xe]
L_8e1bd8:
	stb_s r15,[r13,0x10]
L_8e1bda:
	stb_s r14,[r13,0x11]
L_8e1bdc:
	ldb.a r4,[r0,0x40]
L_8e1be0:
	stb r4,[r13, 0x12]
L_8e1be4:
	ldb_s r14,[r0,0x1]
L_8e1be6:
	stb_s r14,[r13,0x13]
L_8e1be8:
	ldb_s r14,[r0,0x2]
L_8e1bea:
	stb_s r14,[r13,0x14]
L_8e1bec:
	ldb_s r14,[r0,0x3]
L_8e1bee:
	stw_s r1,[r13,0x16]
L_8e1bf0:
	stb_s r14,[r13,0x15]
L_8e1bf2:
	stw_s r3,[r13,0x18]
L_8e1bf4:
	ldb r5,[r0, 0x1]
L_8e1bf8:
	mov_s r0,0xb
L_8e1bfa:
	mov_s r1,0x2
L_8e1bfc:
	bl.d L_8ee034
L_8e1c00:
	ldw_s r3,[r13,0x18]
L_8e1c02:
	b_s L_8e1c22
	.global L_8e1c04
L_8e1c04:
	ldb r4,[r14, 0x4]
L_8e1c08:
	mov_s r0,0xb
L_8e1c0a:
	ldb r5,[r14, 0x5]
L_8e1c0e:
	mov_s r1,0x2
L_8e1c10:
	bl.d L_8ee034
L_8e1c14:
	ldw_s r3,[r14,0xa]
L_8e1c16:
	add r0,r13,0xe
L_8e1c1a:
	mov_s r1,r14
L_8e1c1c:
	bl.d L_8c0460
L_8e1c20:
	mov_s r2,0xc
	.global L_8e1c22
L_8e1c22:
	.byte 0x0d,0x07
