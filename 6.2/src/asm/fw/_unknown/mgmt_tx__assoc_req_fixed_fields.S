/* mgmt_tx__assoc_req_fixed_fields @ 0x8f4e9c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_assoc_req
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, push_cap_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__assoc_req_fixed_fields
mgmt_tx__assoc_req_fixed_fields:
	.global L_8f4e9c
L_8f4e9c:
	push_s blink
L_8f4e9e:
	bl L_8c01e4
L_8f4ea2:
	mov_s r14,r0
L_8f4ea4:
	mov_s r13,r1
L_8f4ea6:
	bl.d L_8e1d78
L_8f4eaa:
	add_s r1,r1,0x5c
L_8f4eac:
	extw_s r0,r0
L_8f4eae:
	ldw r1,[r13, 0x4e]
L_8f4eb2:
	add_s r14,r14,r0
L_8f4eb4:
	stw_s r1,[r14]
L_8f4eb6:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8f4eb8:
	b.d L_8c0254
L_8f4ebc:
	extw_s r0,r0
L_8f4ebe:
	nop_s
