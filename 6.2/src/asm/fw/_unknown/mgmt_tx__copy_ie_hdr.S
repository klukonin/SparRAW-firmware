/* mgmt_tx__copy_ie_hdr @ 0x8d7fd4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_fixed_probe_resp, mgmt_tx__build_probe_resp
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memset0_words, push_cap_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__copy_ie_hdr
mgmt_tx__copy_ie_hdr:
	.global L_8d7fd4
L_8d7fd4:
	push_s blink
L_8d7fd6:
	bl L_8c01e4
L_8d7fda:
	mov_s r14,r0
L_8d7fdc:
	mov_s r13,r1
L_8d7fde:
	bl.d L_8c1cd8
L_8d7fe2:
	mov_s r1,0x8
L_8d7fe4:
	ldw r0,[r13, 0x4e]
L_8d7fe8:
	stw_s r0,[r14,0x8]
L_8d7fea:
	add r0,r14,0xa
L_8d7fee:
	bl.d L_8e1d78
L_8d7ff2:
	add2 r1,r13,0x17
L_8d7ff6:
	add_s r0,r0,0xa
L_8d7ff8:
	b.d L_8c0254
L_8d7ffc:
	extw_s r0,r0
L_8d7ffe:
	nop_s
