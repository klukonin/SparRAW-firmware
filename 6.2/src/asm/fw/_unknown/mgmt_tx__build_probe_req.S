/* mgmt_tx__build_probe_req @ 0x8e9ebc, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PROBE REQ internal IEs are built
 *   PROBE REQ internal & external IEs are built
 * Зовут его: find_main_sm__bf_ntf, tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, app_ies__set_buffer, fw_log_emit0, ie__push_wfa_vendor, ies_block__is_empty, ies_block__merge, mgmt_tx__build_mac_header, mgmt_tx__probe_resp_ies, mid__get_bcon_additional_ies
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__build_probe_req
mgmt_tx__build_probe_req:
	.global L_8e9ebc
L_8e9ebc:
	push_s blink
L_8e9ebe:
	bl.d L_8c01d0
L_8e9ec2:
	add_s r3,r3,0x1c
L_8e9ec4:
	sub sp,sp,0x110
L_8e9ec8:
	mov_s r14,r0
L_8e9eca:
	mov_s r16,r1
L_8e9ecc:
	mov_s r13,r2
L_8e9ece:
	mov r18,r4
L_8e9ed2:
	mov_s r15,r5
L_8e9ed4:
	st_s r0,[sp,0x0]
L_8e9ed6:
	mov_s r0,r2
L_8e9ed8:
	mov_s r1,r14
L_8e9eda:
	bl.d L_8d7db8
L_8e9ede:
	mov_s r2,0x4
L_8e9ee0:
	ld_s r0,[sp,0x0]
L_8e9ee2:
	add3 r14,r13,0x9
L_8e9ee6:
	add_s r0,r0,0x18
L_8e9ee8:
	st_s r0,[sp,0x0]
L_8e9eea:
	mov_s r0,r14
L_8e9eec:
	bl.d L_8cb844
L_8e9ef0:
	mov_s r1,0x4
L_8e9ef2:
	bl.d L_8da1c0
L_8e9ef6:
	mov_s r19,r0
L_8e9ef8:
	breq_s r0,0,L_8e9f1a
L_8e9efa:
	mov_s r1,0x1013bd0
L_8e9f00:
	bl.d L_8dcba8
L_8e9f04:
	mov_s r0,0x2d
L_8e9f06:
	ld_s r0,[sp,0x0]
L_8e9f08:
	mov_s r1,r14
L_8e9f0a:
	mov_s r2,r18
L_8e9f0c:
	bl.d L_8d7f78
L_8e9f10:
	mov_s r3,r15
L_8e9f12:
	ld_s r1,[sp,0x0]
L_8e9f14:
	add_s r1,r1,r0
L_8e9f16:
	st_s r1,[sp,0x0]
L_8e9f18:
	b_s L_8e9f50
	.global L_8e9f1a
L_8e9f1a:
	add_s r0,sp,0x4
L_8e9f1c:
	mov_s r17,r0
L_8e9f1e:
	mov_s r1,r14
L_8e9f20:
	mov_s r2,r18
L_8e9f22:
	bl.d L_8d7f78
L_8e9f26:
	mov_s r3,r15
L_8e9f28:
	mov_s r18,r0
L_8e9f2a:
	mov_s r1,0x1013bf4
L_8e9f30:
	bl.d L_8dcba8
L_8e9f34:
	mov_s r0,0x2d
L_8e9f36:
	add3 r14,sp,0x20
L_8e9f3a:
	add_s r0,r14,0x4
L_8e9f3c:
	mov_s r1,r17
L_8e9f3e:
	mov_s r2,r18
L_8e9f40:
	bl.d L_8e693c
L_8e9f44:
	mov_s r3,0x0
L_8e9f46:
	mov_s r0,sp
L_8e9f48:
	mov_s r1,r19
L_8e9f4a:
	bl.d L_8ddfd0
L_8e9f4e:
	add_s r2,r14,0x4
	.global L_8e9f50
L_8e9f50:
	add r14,r0,0x18
L_8e9f54:
	extw_s r14,r14
L_8e9f56:
	add r1,r13,0xa
L_8e9f5a:
	ld_s r0,[sp,0x0]
L_8e9f5c:
	bl.d L_8e1c94
L_8e9f60:
	mov_s r2,0x0
L_8e9f62:
	extw_s r0,r0
L_8e9f64:
	add_s r14,r14,r0
L_8e9f66:
	extw_s r14,r14
L_8e9f68:
	st r14,[r16]
L_8e9f6c:
	b.d L_8c022c
L_8e9f70:
	add sp,sp,0x110
