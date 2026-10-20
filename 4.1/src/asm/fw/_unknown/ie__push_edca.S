/* ie__push_edca @ 0x8ef7b8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Pushed EDCA IE length %d
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_resp_tlv, mgmt_tx__probe_resp_ies
 * Зовёт сам: fw_log__emit1, memcpy_fw
 */
	.section .text.ie__push_edca,"ax",@progbits
	.global ie__push_edca
ie__push_edca:
	.global L_8ef7b8
L_8ef7b8:
	push_s blink
L_8ef7ba:
	add_s r1,r1,0x12
L_8ef7bc:
	bl.d L_8c0460
L_8ef7c0:
	mov_s r2,0x14
L_8ef7c2:
	mov_s r2,0x100bc74
L_8ef7c8:
	mov_s r0,0xd
L_8ef7ca:
	mov_s r1,0x2
L_8ef7cc:
	bl.d L_8edfcc
L_8ef7d0:
	mov_s r3,0x14
L_8ef7d2:
	mov_s r0,0x14
L_8ef7d4:
	pop_s blink
L_8ef7d6:
	j_s [blink]
