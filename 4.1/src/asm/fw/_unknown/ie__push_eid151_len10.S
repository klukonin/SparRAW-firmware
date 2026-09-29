/* ie__push_eid151_len10 @ 0x8ef864, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_resp_tlv, mgmt_tx__probe_resp_ies
 * Зовёт сам: memcpy_fw
 */
	.section .text.ie__push_eid151_len10,"ax",@progbits
	.global ie__push_eid151_len10
ie__push_eid151_len10:
	.global L_8ef864
L_8ef864:
	push_s blink
L_8ef866:
	mov_s r2,0xa
L_8ef868:
	mov_s r3,0x97
L_8ef86a:
	stb_s r3,[r0]
L_8ef86c:
	stb_s r2,[r0,0x1]
L_8ef86e:
	/* bl.d 0x008c0460 */
	.byte 0xf6,0x0b,0x6f,0xe8
L_8ef872:
	/* _add_s r0,0x2 */
	.byte 0x02,0xe0
L_8ef874:
	mov_s r0,0xc
L_8ef876:
	pop_s blink
L_8ef878:
	j_s [blink]
L_8ef87a:
	nop_s
