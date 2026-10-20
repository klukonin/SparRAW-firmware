/* mgmt_tx__assoc_req_fixed_fields @ 0x8ec6d0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_assoc_req
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, push_cap_info
 */
	.section .text.mgmt_tx__assoc_req_fixed_fields,"ax",@progbits
	.global mgmt_tx__assoc_req_fixed_fields
mgmt_tx__assoc_req_fixed_fields:
	.global L_8ec6d0
L_8ec6d0:
	push_s blink
L_8ec6d2:
	bl L_8c02c4
L_8ec6d6:
	mov_s r14,r0
L_8ec6d8:
	mov_s r13,r1
L_8ec6da:
	bl.d L_8ef784
L_8ec6de:
	add_s r1,r1,0x5c
L_8ec6e0:
	extw_s r0,r0
L_8ec6e2:
	ldw r1,[r13, 0x4e]
L_8ec6e6:
	add_s r14,r14,r0
L_8ec6e8:
	stw_s r1,[r14]
L_8ec6ea:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8ec6ec:
	b.d L_8c0334
L_8ec6f0:
	extw_s r0,r0
L_8ec6f2:
	nop_s
