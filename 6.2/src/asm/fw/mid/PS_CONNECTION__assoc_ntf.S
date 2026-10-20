/* PS_CONNECTION__assoc_ntf @ 0x8c3cd8, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CONNECTION::assoc_ntf (conn_p=0x%x, is_psm_enabled=%d)
 * Зовут его: ps_connection_mgr__on_assoc
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, fw_log_emit2, obj_vt801d64__ctor, psc_if__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global PS_CONNECTION__assoc_ntf
PS_CONNECTION__assoc_ntf:
	.global L_8c3cd8
L_8c3cd8:
	push_s blink
L_8c3cda:
	bl L_8c01e0
L_8c3cde:
	mov_s r13,r0
L_8c3ce0:
	mov_s r14,r1
L_8c3ce2:
	mov_s r15,r2
L_8c3ce4:
	mov_s r1,0x1002500
L_8c3cea:
	mov_s r0,0x2e
L_8c3cec:
	mov_s r2,r14
L_8c3cee:
	bl.d L_8dcc80
L_8c3cf2:
	mov_s r3,r15
L_8c3cf4:
	st_s r14,[r13,0x34]
L_8c3cf6:
	st_s r15,[r13]
L_8c3cf8:
	add r15,r13,0x38
L_8c3cfc:
	mov_s r0,r15
L_8c3cfe:
	mov_s r1,r13
L_8c3d00:
	bl.d L_8d9344
L_8c3d04:
	mov_s r2,r14
L_8c3d06:
	ld_s r2,[r14,0x18]
L_8c3d08:
	add_s r14,r13,0x4
L_8c3d0a:
	mov_s r0,r14
L_8c3d0c:
	mov_s r1,r15
L_8c3d0e:
	bl.d L_8d8b94
L_8c3d12:
	ldb_s r2,[r2,0x10]
L_8c3d14:
	mov_s r1,0x0
L_8c3d16:
	stb_s r1,[r13,0x14]
L_8c3d18:
	stb_s r1,[r13,0x15]
L_8c3d1a:
	st_s r1,[r13,0x18]
L_8c3d1c:
	stb r1,[r13, 0x24]
L_8c3d20:
	st_s r1,[r13,0x28]
L_8c3d22:
	mov_s r0,0x801d5c
L_8c3d28:
	ld_s r2,[r0]
L_8c3d2a:
	ld_s r0,[r0,0x4]
L_8c3d2c:
	st_s r2,[r13,0x1c]
L_8c3d2e:
	st_s r0,[r13,0x20]
L_8c3d30:
	st_s r0,[r13,0x30]
L_8c3d32:
	ld_s r0,[r13]
L_8c3d34:
	st_s r2,[r13,0x2c]
L_8c3d36:
	cmp_s r0,0x0
L_8c3d38:
	mov.ne r0,r14
L_8c3d3c:
	mov.ne r2,r1
L_8c3d40:
	mov.ne r3,r1
L_8c3d44:
	bl.ne.d L_8d9b6c
L_8c3d48:
	mov.ne r4,r1
L_8c3d4c:
	b L_8c024c
