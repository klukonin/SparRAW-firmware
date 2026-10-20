/* ie__push_ssid @ 0x8e2028, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_req_ies, mgmt_tx__probe_resp_ies, mgmt_tx__probe_resp_ies_8d8378
 * Зовёт сам: __ld_r13_to_r13_ret, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__push_ssid
ie__push_ssid:
	.global L_8e2028
L_8e2028:
	push_s blink
L_8e202a:
	push_s r13
L_8e202c:
	mov_s r13,r2
L_8e202e:
	mov_s r2,0x0
L_8e2030:
	stb_s r2,[r0]
L_8e2032:
	stb_s r13,[r0,0x1]
L_8e2034:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e2036:
	breq_s r1,0,L_8e2042
L_8e2038:
	cmp_s r13,0x0
L_8e203a:
	bl.gt.d L_8c0380
L_8e203e:
	mov.gt r2,r13
	.global L_8e2042
L_8e2042:
	b.d L_8c025c
L_8e2046:
	add_s r0,r13,0x2
