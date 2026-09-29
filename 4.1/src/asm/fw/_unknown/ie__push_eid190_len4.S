/* ie__push_eid190_len4 @ 0x8ef84c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__append_probe_resp_ies
 * Зовёт сам: memcpy_fw
 */
	.section .text.ie__push_eid190_len4,"ax",@progbits
	.global ie__push_eid190_len4
ie__push_eid190_len4:
	.global L_8ef84c
L_8ef84c:
	push_s blink
L_8ef84e:
	mov_s r2,0x4
L_8ef850:
	mov_s r3,0xbe
L_8ef852:
	stb_s r3,[r0]
L_8ef854:
	stb_s r2,[r0,0x1]
L_8ef856:
	/* bl.d 0x008c0460 */
	.byte 0x0e,0x0c,0x6f,0xe8
L_8ef85a:
	/* _add_s r0,0x2 */
	.byte 0x02,0xe0
L_8ef85c:
	mov_s r0,0x6
L_8ef85e:
	pop_s blink
L_8ef860:
	j_s [blink]
L_8ef862:
	nop_s
