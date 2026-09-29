/* scan_mngr__connect @ 0x8f1f2c, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::connect() Link UP request to: ADDR-%04X%08X
 *   scan_mngr::connect() in active scan mode
 * Зовут его: scan_mngr__start_connection_cb
 * Зовёт сам: TX_API__free_memory, TX_API__post_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__handle_event, find_main_sm__bcon_args, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal, radio_mgr__get_current_channel, scan_mngr__prob_done, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__connect
scan_mngr__connect:
	.global L_8f1f2c
L_8f1f2c:
	push_s blink
L_8f1f2e:
	bl L_8c01dc
L_8f1f32:
	sub_s sp,sp,0x48
L_8f1f34:
	mov_s r14,r0
L_8f1f36:
	mov_s r13,r1
L_8f1f38:
	ldw_s r2,[r13,0xc]
L_8f1f3a:
	mov_s r1,0x1016690
L_8f1f40:
	mov_s r0,0x29
L_8f1f42:
	bl.d L_8dcc80
L_8f1f46:
	ld_s r3,[r13,0x8]
L_8f1f48:
	ldb r0,[r13, 0x40]
L_8f1f4c:
	mov_s r15,0x0
L_8f1f4e:
	cmp_s r0,0x2
L_8f1f50:
	mov.ne r16,r15
L_8f1f54:
	bne_s L_8f1f74
L_8f1f56:
	mov_s r1,0x10166c8
L_8f1f5c:
	bl.d L_8dcba8
L_8f1f60:
	mov_s r0,0x29
L_8f1f62:
	ldb r0,[r13, 0x38]
L_8f1f66:
	mov_s r15,0x1
L_8f1f68:
	stb r0,[sp, 0x6]
L_8f1f6c:
	ld_s r0,[r13,0x3c]
L_8f1f6e:
	mov r16,sp
L_8f1f72:
	st_s r0,[sp,0x0]
	.global L_8f1f74
L_8f1f74:
	bl.d L_8cc130
L_8f1f78:
	add_s r0,sp,0x44
L_8f1f7a:
	ldb r4,[r14,0x214]
L_8f1f82:
	add r1,r13,0x8
L_8f1f86:
	ld_s r0,[r14,0x7c]
L_8f1f88:
	mov_s r2,r16
L_8f1f8a:
	bl.d L_8da8fc
L_8f1f8e:
	mov_s r3,r15
L_8f1f90:
	mov.f r15,r0
L_8f1f94:
	st_s r0,[r13,0x44]
L_8f1f96:
	bne_s L_8f1fa4
L_8f1f98:
	mov_s r0,r14
L_8f1f9a:
	mov_s r1,0x1
L_8f1f9c:
	bl.d L_8f74c4
L_8f1fa0:
	mov_s r2,r13
L_8f1fa2:
	b_s L_8f1faa
	.global L_8f1fa4
L_8f1fa4:
	bl L_8e9524
L_8f1fa8:
	st_s r0,[r15,0x10]
	.global L_8f1faa
L_8f1faa:
	b.d L_8c0244
L_8f1fae:
	add_s sp,sp,0x48
L_8f1fb0:
	push_s blink
L_8f1fb2:
	bl L_8c01dc
L_8f1fb6:
	mov_s r16,r0
L_8f1fb8:
	mov_s r12,0xf0
L_8f1fba:
	add.f r13,r2,r12
L_8f1fbe:
	mov_s r14,r1
L_8f1fc0:
	mov_s r15,r2
L_8f1fc2:
	beq_s L_8f1fde
	.global L_8f1fc4
L_8f1fc4:
	ld_s r0,[r13,0x20]
L_8f1fc6:
	ld_s r0,[r0,0x18]
L_8f1fc8:
	ld_s r0,[r0,0x50]
L_8f1fca:
	cmp_s r0,0x1
L_8f1fcc:
	mov_s r0,0x1
L_8f1fce:
	sub_s.ne r0,r0,r0
L_8f1fd0:
	extb.f 0x0,r0
L_8f1fd4:
	beq_s L_8f1ff2
L_8f1fd6:
	brne_s r14,0,L_8f1fec
L_8f1fd8:
	mov_s r0,0x1
L_8f1fda:
	st_s r0,[r13,0xc]
L_8f1fdc:
	b_s L_8f201a
	.global L_8f1fde
L_8f1fde:
	mov_s r0,blink
L_8f1fe0:
	mov_s r1,0x11ff
L_8f1fe6:
	bl L_8c9b28
L_8f1fea:
	b_s L_8f1fc4
	.global L_8f1fec
L_8f1fec:
	mov_s r0,0x0
L_8f1fee:
	st_s r0,[r13,0xc]
L_8f1ff0:
	b_s L_8f201a
	.global L_8f1ff2
L_8f1ff2:
	ld_s r0,[r13,0xc]
L_8f1ff4:
	ldw_s r1,[r13,0x28]
L_8f1ff6:
	brne r0,0x1,L_8f201a
L_8f1ffa:
	mov_s r0,0x0
L_8f1ffc:
	cmp_s r14,0x0
L_8f1ffe:
	mov.eq r0,r13
L_8f2002:
	mov.eq r1,0x4
L_8f2006:
	beq_s L_8f2010
L_8f2008:
	st_s r0,[r13,0xc]
L_8f200a:
	brne_s r1,0,L_8f201a
L_8f200c:
	mov_s r0,r13
L_8f200e:
	mov_s r1,0x5
	.global L_8f2010
L_8f2010:
	mov_s r2,r14
L_8f2012:
	mov_s r3,0x0
L_8f2014:
	bl.d L_8d9b6c
L_8f2018:
	mov_s r4,r3
	.global L_8f201a
L_8f201a:
	brne_s r14,0,L_8f2028
L_8f201c:
	ld_s r1,[r15,0x18]
L_8f201e:
	mov_s r0,r16
L_8f2020:
	bl.d L_8e0ce8
L_8f2024:
	ldb_s r1,[r1,0x10]
L_8f2026:
	b_s L_8f202e
	.global L_8f2028
L_8f2028:
	bl.d L_8cb10c
L_8f202c:
	mov_s r0,r16
	.global L_8f202e
L_8f202e:
	mov_s r0,0x0
L_8f2030:
	b.d L_8c0244
L_8f2034:
	st_s r0,[r13,0x24]
L_8f2036:
	nop_s
