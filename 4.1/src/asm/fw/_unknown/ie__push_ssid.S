/* ie__push_ssid @ 0x8ef8dc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_req_ies, mgmt_tx__probe_req_ies, mgmt_tx__probe_resp_ies
 * Зовёт сам: __ld_r13_ret, memcpy_fw
 */
	.section .text.ie__push_ssid,"ax",@progbits
	.global ie__push_ssid
ie__push_ssid:
	.global L_8ef8dc
L_8ef8dc:
	push_s blink
L_8ef8de:
	push_s r13
L_8ef8e0:
	mov_s r13,r2
L_8ef8e2:
	mov_s r2,0x0
L_8ef8e4:
	stb_s r2,[r0]
L_8ef8e6:
	stb_s r13,[r0,0x1]
L_8ef8e8:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8ef8ea:
	breq_s r1,0,L_8ef8f6
L_8ef8ec:
	cmp_s r13,0x0
L_8ef8ee:
	bl.gt.d L_8c0460
L_8ef8f2:
	mov.gt r2,r13
	.global L_8ef8f6
L_8ef8f6:
	b.d L_8c033c
L_8ef8fa:
	add_s r0,r13,0x2
