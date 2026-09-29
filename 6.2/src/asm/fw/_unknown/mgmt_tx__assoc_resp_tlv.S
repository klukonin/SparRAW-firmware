/* mgmt_tx__assoc_resp_tlv @ 0x8f4fa0, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC RESP TLV %d aid %d
 *   ASSOC RESP TLV %d
 * Зовут его: mgmt_tx__build_assoc_resp, mgmt_tx__build_assoc_resp_8f9e88
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit2, fw_log_emit3, ie__push_dmg_capabilities, ie__push_edca, ie__push_eid151_len10
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__assoc_resp_tlv
mgmt_tx__assoc_resp_tlv:
	.global L_8f4fa0
L_8f4fa0:
	push_s blink
L_8f4fa2:
	bl L_8c01d8
L_8f4fa6:
	mov_s r15,r0
L_8f4fa8:
	mov_s r14,r1
L_8f4faa:
	bl.d L_8e1da8
L_8f4fae:
	mov_s r17,r2
L_8f4fb0:
	extw r16,r0
L_8f4fb4:
	add_s r15,r15,r16
L_8f4fb6:
	add1 r1,r14,0x2f
L_8f4fba:
	extb r2,r17
L_8f4fbe:
	bl.d L_8e1fd4
L_8f4fc2:
	mov_s r0,r15
L_8f4fc4:
	extw_s r13,r0
L_8f4fc6:
	mov_s r1,0x100fffc
L_8f4fcc:
	mov_s r0,0x2d
L_8f4fce:
	mov_s r2,0x94
L_8f4fd0:
	mov_s r3,r13
L_8f4fd2:
	bl.d L_8dcd00
L_8f4fd6:
	mov r4,r17
L_8f4fda:
	add_s r0,r13,r15
L_8f4fdc:
	add_s r13,r13,r16
L_8f4fde:
	extw_s r13,r13
L_8f4fe0:
	bl.d L_8e1fbc
L_8f4fe4:
	add3 r1,r14,0x1f
L_8f4fe8:
	extw_s r3,r0
L_8f4fea:
	add_s r13,r13,r3
L_8f4fec:
	extw_s r13,r13
L_8f4fee:
	mov_s r1,0x1010018
L_8f4ff4:
	mov_s r0,0x2d
L_8f4ff6:
	bl.d L_8dcc80
L_8f4ffa:
	mov_s r2,0xdd
L_8f4ffc:
	b.d L_8c023c
L_8f5000:
	mov_s r0,r13
L_8f5002:
	nop_s
