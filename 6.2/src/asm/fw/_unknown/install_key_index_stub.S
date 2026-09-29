/* install_key_index_stub @ 0x8f0c98, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TODO !!!! install_key ... Need to support key index
 * Зовут его: l2mgr__data_port_open_and_keys, mlme_sm_8027a0__action_8f3314
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit0, lmac_cmd_pool__alloc, lmac_if__post_cmd, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global install_key_index_stub
install_key_index_stub:
	.global L_8f0c98
L_8f0c98:
	push_s blink
L_8f0c9a:
	bl L_8c01d8
L_8f0c9e:
	mov_s r14,r0
L_8f0ca0:
	mov_s r15,r1
L_8f0ca2:
	mov_s r17,r2
L_8f0ca4:
	bl.d L_8c3284
L_8f0ca8:
	mov r16,r4
L_8f0cac:
	mov_s r13,r0
L_8f0cae:
	st_s r15,[r0,0x4]
L_8f0cb0:
	mov_s r0,0x803c00
L_8f0cb6:
	ld_s r0,[r0,0xc]
L_8f0cb8:
	breq_s r0,0,L_8f0cc8
L_8f0cba:
	cmp r16,0x0
L_8f0cbe:
	mov_s r0,0x8
L_8f0cc0:
	mov.eq r0,r14
L_8f0cc4:
	st_s r0,[r13]
L_8f0cc6:
	b_s L_8f0cca
	.global L_8f0cc8
L_8f0cc8:
	st_s r14,[r13]
	.global L_8f0cca
L_8f0cca:
	mov_s r1,0x100eda0
L_8f0cd0:
	bl.d L_8dcba8
L_8f0cd4:
	mov_s r0,0x20
L_8f0cd6:
	mov_s r0,0x38
L_8f0cd8:
	st_s r0,[r13,0x8]
L_8f0cda:
	mov_s r2,0x10
L_8f0cdc:
	st_s r2,[r13,0xc]
L_8f0cde:
	add r0,r13,0x10
L_8f0ce2:
	bl.d L_8c0380
L_8f0ce6:
	mov_s r1,r17
L_8f0ce8:
	mov_s r0,r13
L_8f0cea:
	mov_s r1,0x18
L_8f0cec:
	mov_s r2,0x20
L_8f0cee:
	bl.d L_8e5204
L_8f0cf2:
	mov_s r3,0x0
L_8f0cf4:
	b L_8c023c
