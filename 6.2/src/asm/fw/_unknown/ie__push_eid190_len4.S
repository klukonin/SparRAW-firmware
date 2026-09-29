/* ie__push_eid190_len4 @ 0x8e1fa4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__append_probe_resp_ies
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__push_eid190_len4
ie__push_eid190_len4:
	.global L_8e1fa4
L_8e1fa4:
	push_s blink
L_8e1fa6:
	mov_s r2,0x4
L_8e1fa8:
	mov_s r3,0xbe
L_8e1faa:
	stb_s r3,[r0]
L_8e1fac:
	stb_s r2,[r0,0x1]
L_8e1fae:
	bl.d L_8c0380
L_8e1fb2:
	/* _add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e1fb4:
	mov_s r0,0x6
L_8e1fb6:
	pop_s blink
L_8e1fb8:
	j_s [blink]
L_8e1fba:
	nop_s
