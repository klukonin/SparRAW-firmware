/* set_old_wilocity_vs @ 0x8e69e0, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   set_old_wilocity_vs = flags %x srv_id_1 = %x srv_id_2 = %x
 * Зовут его: mlme_sm_802458__action_8f1080, set_vendor_specific_version
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit3, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global set_old_wilocity_vs
set_old_wilocity_vs:
	.global L_8e69e0
L_8e69e0:
	push_s blink
L_8e69e2:
	bl L_8c01e0
L_8e69e6:
	mov.f r14,r1
L_8e69ea:
	mov_s r15,r3
L_8e69ec:
	mov_s r1,0x100c6d8
L_8e69f2:
	add3 r13,r0,0x20
L_8e69f6:
	bne_s L_8e6a2c
L_8e69f8:
	ld_s r0,[gp,-0x18]
L_8e69fa:
	mov_s r14,0xaa
L_8e69fc:
	stb_s r14,[r13,0xf]
L_8e69fe:
	mov_s r14,0x6c
L_8e6a00:
	mov_s r3,0x0
L_8e6a02:
	stb_s r3,[r13,0xe]
L_8e6a04:
	stb_s r14,[r13,0x10]
L_8e6a06:
	stb_s r3,[r13,0x11]
L_8e6a08:
	add_s r0,r0,0x20
L_8e6a0a:
	ldb_s r3,[r0,0xc]
L_8e6a0c:
	stb_s r3,[r13,0x12]
L_8e6a0e:
	ldb_s r14,[r0,0xd]
L_8e6a10:
	stb_s r14,[r13,0x13]
L_8e6a12:
	ldb_s r14,[r0,0xe]
L_8e6a14:
	stb_s r14,[r13,0x14]
L_8e6a16:
	ldb_s r14,[r0,0xf]
L_8e6a18:
	stw_s r2,[r13,0x16]
L_8e6a1a:
	stb_s r14,[r13,0x15]
L_8e6a1c:
	stw_s r15,[r13,0x18]
L_8e6a1e:
	ldb r4,[r0, 0xd]
L_8e6a22:
	mov_s r0,0x2b
L_8e6a24:
	bl.d L_8dcd00
L_8e6a28:
	ldw_s r2,[r13,0x18]
L_8e6a2a:
	b_s L_8e6a46
	.global L_8e6a2c
L_8e6a2c:
	ldb r4,[r14, 0x5]
L_8e6a30:
	mov_s r0,0x2b
L_8e6a32:
	ldw_s r2,[r14,0xa]
L_8e6a34:
	bl.d L_8dcd00
L_8e6a38:
	ldb_s r3,[r14,0x4]
L_8e6a3a:
	add r0,r13,0xe
L_8e6a3e:
	mov_s r1,r14
L_8e6a40:
	bl.d L_8c0380
L_8e6a44:
	mov_s r2,0xc
	.global L_8e6a46
L_8e6a46:
	b L_8c024c
L_8e6a4a:
	nop_s
