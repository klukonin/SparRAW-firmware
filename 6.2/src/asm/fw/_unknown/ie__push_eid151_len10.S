/* ie__push_eid151_len10 @ 0x8e1fbc, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_resp_tlv, mgmt_tx__probe_resp_ies_8d8378
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__push_eid151_len10
ie__push_eid151_len10:
	.global L_8e1fbc
L_8e1fbc:
	push_s blink
L_8e1fbe:
	mov_s r2,0xa
L_8e1fc0:
	mov_s r3,0x97
L_8e1fc2:
	stb_s r3,[r0]
L_8e1fc4:
	stb_s r2,[r0,0x1]
L_8e1fc6:
	bl.d L_8c0380
L_8e1fca:
	/* _add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e1fcc:
	mov_s r0,0xc
L_8e1fce:
	pop_s blink
L_8e1fd0:
	j_s [blink]
L_8e1fd2:
	nop_s
