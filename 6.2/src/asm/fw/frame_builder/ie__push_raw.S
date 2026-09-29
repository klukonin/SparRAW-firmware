/* ie__push_raw @ 0x8e1ff0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_req_ies, mgmt_tx__probe_resp_ies
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__push_raw
ie__push_raw:
	.global L_8e1ff0
L_8e1ff0:
	push_s blink
L_8e1ff2:
	bl L_8c01dc
L_8e1ff6:
	mov.f r13,r1
L_8e1ffa:
	mov_s r16,r0
L_8e1ffc:
	beq_s L_8e2014
	.global L_8e1ffe
L_8e1ffe:
	ldb_s r2,[r13,0x1]
L_8e2000:
	brlt r2,0x1,L_8e2022
L_8e2004:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8e2006:
	mov_s r0,r16
L_8e2008:
	bl.d L_8c0380
L_8e200c:
	mov_s r1,r13
L_8e200e:
	ldb_s r0,[r13,0x1]
L_8e2010:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e2012:
	b_s L_8e2024
	.global L_8e2014
L_8e2014:
	mov_s r0,blink
L_8e2016:
	mov_s r1,0x11d4
L_8e201c:
	bl L_8c9b28
L_8e2020:
	b_s L_8e1ffe
	.global L_8e2022
L_8e2022:
	mov_s r0,0x0
	.global L_8e2024
L_8e2024:
	b L_8c0244
