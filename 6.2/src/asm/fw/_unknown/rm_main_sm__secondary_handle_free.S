/* rm_main_sm__secondary_handle_free @ 0x8e4e48, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::secondary_handle_free. Handle:0x%x, CB:0x%x
 *   rm_main_sm::secondary_handle_free. Next request:[Handle:0x%x][type:%d]
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit2, fw_sysassert_fatal, radio_mgr__free_handle, rm_req__get_next, sm__defer_call, tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__secondary_handle_free
rm_main_sm__secondary_handle_free:
	.global L_8e4e48
L_8e4e48:
	push_s blink
L_8e4e4a:
	bl L_8c01e4
L_8e4e4e:
	mov_s r14,r0
L_8e4e50:
	ldb_s r0,[r0,0x3]
L_8e4e52:
	mov_s r13,r1
L_8e4e54:
	breq_s r0,0,L_8e4e66
L_8e4e56:
	mov_s r1,0x1019324
L_8e4e5c:
	mov_s r0,0x28
L_8e4e5e:
	mov_s r2,r13
L_8e4e60:
	bl.d L_8dcc80
L_8e4e64:
	ld_s r3,[r13,0xc]
	.global L_8e4e66
L_8e4e66:
	add2 r0,r14,0x1f
L_8e4e6a:
	bl.d L_8e2884
L_8e4e6e:
	mov_s r1,r13
L_8e4e70:
	ld_s r0,[r14,0xc]
L_8e4e72:
	bl.d L_8ddb0c
L_8e4e76:
	mov_s r1,r13
L_8e4e78:
	bl.d L_8cc65c
L_8e4e7c:
	ld_s r0,[r14,0x8]
L_8e4e7e:
	mov.f r13,r0
L_8e4e82:
	beq_s L_8e4ea4
L_8e4e84:
	ldb_s r0,[r14,0x3]
L_8e4e86:
	ld_s r3,[r13,0x14]
L_8e4e88:
	breq_s r0,0,L_8e4e98
L_8e4e8a:
	mov_s r1,0x101935c
L_8e4e90:
	mov_s r0,0x28
L_8e4e92:
	bl.d L_8dcc80
L_8e4e96:
	mov_s r2,r13
	.global L_8e4e98
L_8e4e98:
	ld_s r0,[r13,0x14]
L_8e4e9a:
	cmp_s r0,0x1
L_8e4e9c:
	mov.eq r0,r14
L_8e4ea0:
	mov_s r1,0x6
L_8e4ea2:
	beq_s L_8e4ea8
	.global L_8e4ea4
L_8e4ea4:
	mov_s r0,r14
L_8e4ea6:
	mov_s r1,0x1
	.global L_8e4ea8
L_8e4ea8:
	mov_s r2,0x0
L_8e4eaa:
	mov_s r3,r2
L_8e4eac:
	bl.d L_8e7044
L_8e4eb0:
	mov_s r4,r2
L_8e4eb2:
	b L_8c0254
L_8e4eb6:
	nop_s
L_8e4eb8:
	push_s blink
L_8e4eba:
	push_s r13
L_8e4ebc:
	mov_s r13,r1
L_8e4ebe:
	ld_s r1,[r1,0x24]
L_8e4ec0:
	brne r0,r1,L_8e4ed6
	.global L_8e4ec4
L_8e4ec4:
	mov_s r0,r13
L_8e4ec6:
	mov_s r1,0x1
L_8e4ec8:
	mov_s r2,0x0
L_8e4eca:
	mov_s r3,r2
L_8e4ecc:
	bl.d L_8d9b6c
L_8e4ed0:
	mov_s r4,r2
L_8e4ed2:
	b L_8c025c
	.global L_8e4ed6
L_8e4ed6:
	mov_s r0,blink
L_8e4ed8:
	mov_s r1,0x8b
L_8e4eda:
	bl.d L_8c9b28
L_8e4ede:
	bset_s r1,r1,0xc
L_8e4ee0:
	b_s L_8e4ec4
L_8e4ee2:
	nop_s
