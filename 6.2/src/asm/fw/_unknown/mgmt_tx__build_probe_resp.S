/* mgmt_tx__build_probe_resp @ 0x8e9f74, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PROBE RESP no external APP IEs exist. Building internal IEs only.
 *   PROBE RESP internal and external APP IEs are built.
 *   PROBE RESP total length: %d bytes
 * Зовут его: find_main_sm__probe_req_in_search, state_sm_8030f4__action_8f76d8, tx_probe__send_probe_resp
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, app_ies__set_buffer, fw_log_emit0, fw_log_emit1, ie__push_wfa_vendor, ies_block__is_empty, ies_block__merge, mgmt_tx__append_probe_resp_ies, mgmt_tx__build_mac_header, mgmt_tx__copy_ie_hdr, mid__get_bcon_additional_ies
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__build_probe_resp
mgmt_tx__build_probe_resp:
	.global L_8e9f74
L_8e9f74:
	push_s blink
L_8e9f76:
	bl L_8c01cc
L_8e9f7a:
	sub sp,sp,0x110
L_8e9f7e:
	mov_s r14,r0
L_8e9f80:
	mov_s r17,r1
L_8e9f82:
	mov_s r13,r2
L_8e9f84:
	mov_s r15,r3
L_8e9f86:
	mov r16,r4
L_8e9f8a:
	st_s r0,[sp,0x0]
L_8e9f8c:
	add_s r3,r3,0x1c
L_8e9f8e:
	mov_s r0,r2
L_8e9f90:
	mov_s r1,r14
L_8e9f92:
	bl.d L_8d7db8
L_8e9f96:
	mov_s r2,0x5
L_8e9f98:
	ld_s r0,[sp,0x0]
L_8e9f9a:
	add3 r14,r13,0x9
L_8e9f9e:
	add_s r0,r0,0x18
L_8e9fa0:
	st_s r0,[sp,0x0]
L_8e9fa2:
	bl.d L_8d7fd4
L_8e9fa6:
	mov_s r1,r14
L_8e9fa8:
	ld_s r1,[sp,0x0]
L_8e9faa:
	add r19,r0,0x18
L_8e9fae:
	add_s r1,r1,r0
L_8e9fb0:
	st_s r1,[sp,0x0]
L_8e9fb2:
	mov_s r0,r14
L_8e9fb4:
	bl.d L_8cb844
L_8e9fb8:
	mov_s r1,0x5
L_8e9fba:
	mov_s r20,r0
L_8e9fbc:
	ld.as r0,[r15,0x61]
L_8e9fc0:
	mov_s r15,0x1
L_8e9fc2:
	cmp_s r0,0x0
L_8e9fc4:
	sub_s.ne r15,r15,r15
L_8e9fc6:
	bl.d L_8da1c0
L_8e9fca:
	mov_s r0,r20
L_8e9fcc:
	extw r19,r19
L_8e9fd0:
	breq_s r0,0,L_8e9ff0
L_8e9fd2:
	mov_s r1,0x1013c50
L_8e9fd8:
	bl.d L_8dcba8
L_8e9fdc:
	mov_s r0,0x2d
L_8e9fde:
	ld_s r0,[sp,0x0]
L_8e9fe0:
	mov_s r1,r14
L_8e9fe2:
	bl.d L_8d8000
L_8e9fe6:
	mov_s r2,r15
L_8e9fe8:
	ld_s r1,[sp,0x0]
L_8e9fea:
	add_s r1,r1,r0
L_8e9fec:
	st_s r1,[sp,0x0]
L_8e9fee:
	b_s L_8ea022
	.global L_8e9ff0
L_8e9ff0:
	mov_s r1,0x1013c94
L_8e9ff6:
	bl.d L_8dcba8
L_8e9ffa:
	mov_s r0,0x2d
L_8e9ffc:
	add_s r0,sp,0x4
L_8e9ffe:
	mov_s r18,r0
L_8ea000:
	mov_s r1,r14
L_8ea002:
	bl.d L_8d8000
L_8ea006:
	mov_s r2,r15
L_8ea008:
	mov_s r2,r0
L_8ea00a:
	add3 r14,sp,0x20
L_8ea00e:
	add_s r0,r14,0x4
L_8ea010:
	mov_s r1,r18
L_8ea012:
	bl.d L_8e693c
L_8ea016:
	mov_s r3,r16
L_8ea018:
	mov_s r0,sp
L_8ea01a:
	mov_s r1,r20
L_8ea01c:
	bl.d L_8ddfd0
L_8ea020:
	add_s r2,r14,0x4
	.global L_8ea022
L_8ea022:
	add r14,r19,r0
L_8ea026:
	extw_s r14,r14
L_8ea028:
	add r1,r13,0xa
L_8ea02c:
	ld_s r0,[sp,0x0]
L_8ea02e:
	bl.d L_8e1c94
L_8ea032:
	mov_s r2,0x0
L_8ea034:
	extw_s r0,r0
L_8ea036:
	add_s r2,r14,r0
L_8ea038:
	extw_s r2,r2
L_8ea03a:
	st r2,[r17]
L_8ea03e:
	mov_s r1,0x1013cc8
L_8ea044:
	bl.d L_8dcc10
L_8ea048:
	mov_s r0,0x2d
L_8ea04a:
	b.d L_8c0224
L_8ea04e:
	add sp,sp,0x110
L_8ea052:
	nop_s
