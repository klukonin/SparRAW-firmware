/* mgmt_tx__build_probe_req @ 0x8f1e78, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PROBE REQ internal IEs are built
 *   PROBE REQ internal & external IEs are built
 *   Build serv: Probe Req 60GHz Capability length %d total %d
 * Зовут его: find_main_sm__bf_ntf, tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, app_ies__set_buffer, fw_log__emit0, fw_log__emit2, ie__push_wfa_vendor, ies_block__is_empty, ies_block__merge, log_hexdump, mgmt_tx__build_mac_header, mgmt_tx__probe_req_ies, mid__get_bcon_additional_ies
 */
	.section .text.mgmt_tx__build_probe_req,"ax",@progbits
	.global mgmt_tx__build_probe_req
mgmt_tx__build_probe_req:
	.global L_8f1e78
L_8f1e78:
	push_s blink
L_8f1e7a:
	bl.d L_8c02ac
L_8f1e7e:
	add_s r3,r3,0x10
L_8f1e80:
	sub sp,sp,0x110
L_8f1e84:
	mov_s r13,r0
L_8f1e86:
	mov_s r16,r1
L_8f1e88:
	mov_s r15,r2
L_8f1e8a:
	mov r17,r4
L_8f1e8e:
	mov r19,r5
L_8f1e92:
	st_s r0,[sp,0x0]
L_8f1e94:
	mov_s r0,r2
L_8f1e96:
	mov_s r1,r13
L_8f1e98:
	bl.d L_8ec5c0
L_8f1e9c:
	mov_s r2,0x4
L_8f1e9e:
	ld_s r0,[sp,0x0]
L_8f1ea0:
	add3 r14,r15,0x9
L_8f1ea4:
	add_s r0,r0,0x18
L_8f1ea6:
	st_s r0,[sp,0x0]
L_8f1ea8:
	mov_s r0,r14
L_8f1eaa:
	bl.d L_8c97fc
L_8f1eae:
	mov_s r1,0x4
L_8f1eb0:
	bl.d L_8d70f0
L_8f1eb4:
	mov_s r20,r0
L_8f1eb6:
	breq_s r0,0,L_8f1ed4
L_8f1eb8:
	mov_s r2,0x10106c4
L_8f1ebe:
	mov_s r0,0xd
L_8f1ec0:
	bl.d L_8edfb0
L_8f1ec4:
	mov_s r1,0x2
L_8f1ec6:
	ld_s r0,[sp,0x0]
L_8f1ec8:
	mov_s r1,r14
L_8f1eca:
	mov_s r2,r17
L_8f1ecc:
	bl.d L_8eca28
L_8f1ed0:
	mov_s r3,r19
L_8f1ed2:
	b_s L_8f1f0c
	.global L_8f1ed4
L_8f1ed4:
	add_s r0,sp,0x4
L_8f1ed6:
	mov_s r18,r0
L_8f1ed8:
	mov_s r1,r14
L_8f1eda:
	mov_s r2,r17
L_8f1edc:
	bl.d L_8eca28
L_8f1ee0:
	mov_s r3,r19
L_8f1ee2:
	mov_s r17,r0
L_8f1ee4:
	mov_s r2,0x10106e8
L_8f1eea:
	mov_s r0,0xd
L_8f1eec:
	bl.d L_8edfb0
L_8f1ef0:
	mov_s r1,0x2
L_8f1ef2:
	add3 r14,sp,0x20
L_8f1ef6:
	add_s r0,r14,0x4
L_8f1ef8:
	mov_s r1,r18
L_8f1efa:
	mov_s r2,r17
L_8f1efc:
	bl.d L_8e1afc
L_8f1f00:
	mov_s r3,0x0
L_8f1f02:
	mov_s r0,sp
L_8f1f04:
	mov_s r1,r20
L_8f1f06:
	bl.d L_8da098
L_8f1f0a:
	add_s r2,r14,0x4
	.global L_8f1f0c
L_8f1f0c:
	add r14,r0,0x18
L_8f1f10:
	extw_s r14,r14
L_8f1f12:
	add r1,r15,0xa
L_8f1f16:
	ld_s r0,[sp,0x0]
L_8f1f18:
	bl.d L_8ef740
L_8f1f1c:
	mov_s r2,0x0
L_8f1f1e:
	extw_s r3,r0
L_8f1f20:
	add r17,r14,r3
L_8f1f24:
	extw r17,r17
L_8f1f28:
	mov_s r2,0x1010714
L_8f1f2e:
	mov_s r0,0xd
L_8f1f30:
	mov_s r1,0x2
L_8f1f32:
	bl.d L_8edff8
L_8f1f36:
	mov r4,r17
L_8f1f3a:
	st r17,[r16]
L_8f1f3e:
	mov_s r0,r13
L_8f1f40:
	bl.d L_8c7f90
L_8f1f44:
	mov_s r1,r17
L_8f1f46:
	b.d L_8c0304
L_8f1f4a:
	add sp,sp,0x110
L_8f1f4e:
	nop_s
