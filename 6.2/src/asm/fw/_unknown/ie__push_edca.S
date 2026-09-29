/* ie__push_edca @ 0x8e1da8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Pushed EDCA IE length %d
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_resp_tlv, mgmt_tx__probe_resp_ies_8d8378
 * Зовёт сам: fw_log_emit1, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__push_edca
ie__push_edca:
	.global L_8e1da8
L_8e1da8:
	push_s blink
L_8e1daa:
	add_s r1,r1,0x12
L_8e1dac:
	bl.d L_8c0380
L_8e1db0:
	mov_s r2,0x14
L_8e1db2:
	mov_s r1,0x100faf4
L_8e1db8:
	mov_s r0,0x2d
L_8e1dba:
	bl.d L_8dcc10
L_8e1dbe:
	mov_s r2,0x14
L_8e1dc0:
	mov_s r0,0x14
L_8e1dc2:
	pop_s blink
L_8e1dc4:
	j_s [blink]
L_8e1dc6:
	nop_s
