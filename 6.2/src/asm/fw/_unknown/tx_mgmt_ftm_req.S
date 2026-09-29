/* tx_mgmt_ftm_req @ 0x8e9d48, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] tx_mgmt_ftm_req: update BSS for non associates state
 * Зовут его: state_sm_803424__action_8f064c
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, frame__build_ftm_request, fw_log_emit0, memcpy_fw, mgmt_tx__begin_frame, mid__state_is_2_or_3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_mgmt_ftm_req
tx_mgmt_ftm_req:
	.global L_8e9d48
L_8e9d48:
	push_s blink
L_8e9d4a:
	bl L_8c01d8
L_8e9d4e:
	mov_s r15,r0
L_8e9d50:
	mov_s r14,r1
L_8e9d52:
	mov_s r13,r2
L_8e9d54:
	mov_s r17,r3
L_8e9d56:
	mov r16,r4
L_8e9d5a:
	mov_s r0,0x0
L_8e9d5c:
	st_s r0,[r1]
L_8e9d5e:
	mov_s r0,r15
L_8e9d60:
	bl.d L_8e9c7c
L_8e9d64:
	mov r4,0xd
L_8e9d68:
	ld_s r0,[r13,0x4c]
L_8e9d6a:
	cmp_s r0,0x2
L_8e9d6c:
	mov_s r0,0x1
L_8e9d6e:
	sub_s.ne r0,r0,r0
L_8e9d70:
	extb.f 0x0,r0
L_8e9d74:
	bne_s L_8e9d98
L_8e9d76:
	bl.d L_8da488
L_8e9d7a:
	ldb_s r0,[r13,0x10]
L_8e9d7c:
	brne_s r0,0,L_8e9d98
L_8e9d7e:
	mov_s r1,0x1013e70
L_8e9d84:
	bl.d L_8dcba8
L_8e9d88:
	mov_s r0,0x2d
L_8e9d8a:
	add r1,r17,0x1c
L_8e9d8e:
	add r0,r15,0x10
L_8e9d92:
	bl.d L_8c0380
L_8e9d96:
	mov_s r2,0x6
	.global L_8e9d98
L_8e9d98:
	ld_s r13,[r14]
L_8e9d9a:
	mov_s r1,r17
L_8e9d9c:
	st r13,[r16]
L_8e9da0:
	add_s r0,r15,r13
L_8e9da2:
	bl.d L_8f5040
L_8e9da6:
	mov_s r2,r16
L_8e9da8:
	add_s r0,r0,r13
L_8e9daa:
	b.d L_8c023c
L_8e9dae:
	st_s r0,[r14]
