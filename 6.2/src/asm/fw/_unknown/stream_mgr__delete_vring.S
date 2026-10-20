/* stream_mgr__delete_vring @ 0x8c8ebc, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STARTED DELETE BCAST VRING. Vring: %d, Pring: %d
 *   stream_mgr::delete_vring(). Vring idx: %d
 * Зовут его: l2_mgr__pcp_stop, wmi_bcast_vring_cfg, wmi_vring_cfg
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, ba_sm_evt_type, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, tx_list__remove, vring_list__find, vring_schd__remove_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__delete_vring
stream_mgr__delete_vring:
	.global L_8c8ebc
L_8c8ebc:
	push_s blink
L_8c8ebe:
	bl.d L_8c01e4
L_8c8ec2:
	mov_s r2,r0
L_8c8ec4:
	brhs r0,0xa,L_8c8f12
L_8c8ec8:
	mov_s r0,0x847f34
L_8c8ece:
	sub r0,r0,0x400
L_8c8ed2:
	add2_s r0,r0,r2
L_8c8ed4:
	ld r14,[r0,0x44c]
L_8c8edc:
	breq_s r14,0,L_8c8f1e
L_8c8ede:
	ld_s r1,[r14,0xc]
L_8c8ee0:
	mov_s r13,0x1
L_8c8ee2:
	mov_s r0,0x0
L_8c8ee4:
	breq_s r1,0,L_8c8f06
L_8c8ee6:
	mov_s r1,0x1010b34
L_8c8eec:
	mov_s r0,0x2b
L_8c8eee:
	bl.d L_8dcc80
L_8c8ef2:
	mov_s r3,r13
L_8c8ef4:
	st_s r13,[r14,0x58]
L_8c8ef6:
	mov_s r0,r14
L_8c8ef8:
	mov_s r1,0x6
L_8c8efa:
	mov_s r2,0x24
	.global L_8c8efc
L_8c8efc:
	mov_s r3,0x0
L_8c8efe:
	bl.d L_8d9c4c
L_8c8f02:
	mov_s r4,r3
L_8c8f04:
	b_s L_8c8f1e
	.global L_8c8f06
L_8c8f06:
	st_s r0,[r14,0x54]
L_8c8f08:
	st_s r13,[r14,0x58]
L_8c8f0a:
	mov_s r0,r14
L_8c8f0c:
	mov_s r1,r13
L_8c8f0e:
	mov_s r2,0x25
L_8c8f10:
	b_s L_8c8efc
	.global L_8c8f12
L_8c8f12:
	mov_s r1,0x1010b68
L_8c8f18:
	bl.d L_8dcc10
L_8c8f1c:
	mov_s r0,0x1b
	.global L_8c8f1e
L_8c8f1e:
	b L_8c0254
L_8c8f22:
	nop_s
L_8c8f24:
	push_s blink
L_8c8f26:
	push_s r13
L_8c8f28:
	mov_s r2,r1
L_8c8f2a:
	mov_s r0,0x0
L_8c8f2c:
	push_s r0
L_8c8f2e:
	mov_s r13,0x804dbc
L_8c8f34:
	mov_s r3,sp
L_8c8f36:
	mov_s r0,r13
L_8c8f38:
	bl.d L_8ebe80
L_8c8f3c:
	add_s r1,r13,0x4
L_8c8f3e:
	brne_s r0,0,L_8c8f4e
L_8c8f40:
	mov_s r0,blink
L_8c8f42:
	mov_s r1,L_8c12b8-0x8c0000
L_8c8f48:
	bl L_8c9b28
L_8c8f4c:
	b_s L_8c8f5e
	.global L_8c8f4e
L_8c8f4e:
	add_s r0,r13,0x4
L_8c8f50:
	bl.d L_8e2884
L_8c8f54:
	ld_s r1,[sp,0x0]
L_8c8f56:
	mov_s r0,r13
L_8c8f58:
	bl.d L_8c8e90
L_8c8f5c:
	ld_s r1,[sp,0x0]
	.global L_8c8f5e
L_8c8f5e:
	b.d L_8c025c
L_8c8f62:
	add_s sp,sp,0x4
L_8c8f64:
	j_s [blink]
L_8c8f66:
	nop_s
