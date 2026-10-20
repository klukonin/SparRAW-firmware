/* vring_schd__resume_vring @ 0x8e2cbc, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schd::resume_vring. vr_index:%d.
 * Зовут его: conn_mgr__resume_all_vrings, l2_mgr__scan_complete_handle
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__handle_event, fw_log_emit1, fw_sysassert_fatal, hwd_dma__get_881c80, lmac_if_echo_evt_handler, tx_list__remove, vring__ack_and_unmask_irq, vring_list__find, vring_schd__move_to_ready
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__resume_vring
vring_schd__resume_vring:
	.global L_8e2cbc
L_8e2cbc:
	push_s blink
L_8e2cbe:
	push_s r13
L_8e2cc0:
	mov_s r13,r0
L_8e2cc2:
	ld_s r0,[r0]
L_8e2cc4:
	breq_s r0,0,L_8e2cd8
	.global L_8e2cc6
L_8e2cc6:
	ld_s r0,[r13]
L_8e2cc8:
	mov_s r1,0xb
L_8e2cca:
	mov_s r2,0x0
L_8e2ccc:
	mov_s r3,r2
L_8e2cce:
	bl.d L_8d9b6c
L_8e2cd2:
	mov_s r4,r2
L_8e2cd4:
	b L_8c025c
	.global L_8e2cd8
L_8e2cd8:
	mov_s r0,blink
L_8e2cda:
	mov_s r1,0x1263
L_8e2ce0:
	bl L_8c9b28
L_8e2ce4:
	b_s L_8e2cc6
L_8e2ce6:
	nop_s
L_8e2ce8:
	push_s blink
L_8e2cea:
	bl.d L_8c01dc
L_8e2cee:
	mov_s r0,0x0
L_8e2cf0:
	mov_s r16,r1
L_8e2cf2:
	push_s r0
L_8e2cf4:
	mov_s r1,0x100bc14
L_8e2cfa:
	mov_s r0,0x27
L_8e2cfc:
	bl.d L_8dcc10
L_8e2d00:
	mov_s r2,r16
L_8e2d02:
	mov_s r13,0x804dbc
L_8e2d08:
	mov_s r3,sp
L_8e2d0a:
	mov_s r0,r13
L_8e2d0c:
	add_s r1,r13,0x4
L_8e2d0e:
	bl.d L_8ebe80
L_8e2d12:
	mov_s r2,r16
L_8e2d14:
	brne_s r0,0,L_8e2d24
L_8e2d16:
	mov_s r0,blink
L_8e2d18:
	mov_s r1,0x12ba
L_8e2d1e:
	bl L_8c9b28
L_8e2d22:
	b_s L_8e2d4c
	.global L_8e2d24
L_8e2d24:
	ld_s r0,[sp,0x0]
L_8e2d26:
	mov_s r1,0x1
L_8e2d28:
	st_s r1,[r0,0x20]
L_8e2d2a:
	bl.d L_8d0894
L_8e2d2e:
	mov_s r0,r16
L_8e2d30:
	ld_s r1,[sp,0x0]
L_8e2d32:
	brne r0,0x1,L_8e2d46
L_8e2d36:
	bl.d L_8e2884
L_8e2d3a:
	add_s r0,r13,0x4
L_8e2d3c:
	mov_s r0,r13
L_8e2d3e:
	bl.d L_8c24b0
L_8e2d42:
	ld_s r1,[sp,0x0]
L_8e2d44:
	b_s L_8e2d4c
	.global L_8e2d46
L_8e2d46:
	bl.d L_8d85d4
L_8e2d4a:
	mov_s r0,r1
	.global L_8e2d4c
L_8e2d4c:
	b.d L_8c0244
L_8e2d50:
	add_s sp,sp,0x4
L_8e2d52:
	nop_s
L_8e2d54:
	mov_s r0,r1
L_8e2d56:
	b.d L_8db79c
L_8e2d5a:
	mov_s r1,0x1
