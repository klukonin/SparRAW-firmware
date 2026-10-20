/* ie__push_wfa_vendor @ 0x8e1c94, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, mgmt_tx__build_assoc_resp_8f9e88, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp, mgmt_tx__probe_resp_ies_8d8378
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__push_wfa_vendor
ie__push_wfa_vendor:
	.global L_8e1c94
L_8e1c94:
	push_s blink
L_8e1c96:
	bl L_8c01e4
L_8e1c9a:
	mov_s r13,r0
L_8e1c9c:
	mov_s r14,r2
L_8e1c9e:
	mov_s r0,0xdd
L_8e1ca0:
	stb_s r0,[r13]
L_8e1ca2:
	mov_s r0,0xf
L_8e1ca4:
	stb_s r0,[r13,0x1]
L_8e1ca6:
	mov_s r0,0x50
L_8e1ca8:
	stb_s r0,[r13,0x2]
L_8e1caa:
	mov_s r0,0x6f
L_8e1cac:
	stb_s r0,[r13,0x3]
L_8e1cae:
	mov_s r0,0x9a
L_8e1cb0:
	stb_s r0,[r13,0x4]
L_8e1cb2:
	mov_s r0,0x17
L_8e1cb4:
	stb_s r0,[r13,0x5]
L_8e1cb6:
	mov_s r0,0x1
L_8e1cb8:
	stb_s r0,[r13,0x6]
L_8e1cba:
	mov_s r0,0x9
L_8e1cbc:
	stb_s r0,[r13,0x7]
L_8e1cbe:
	mov_s r0,0x0
L_8e1cc0:
	stb_s r0,[r13,0x8]
L_8e1cc2:
	mov_s r0,0x7
L_8e1cc4:
	stb_s r0,[r13,0x9]
L_8e1cc6:
	add r0,r13,0xa
L_8e1cca:
	bl.d L_8c0380
L_8e1cce:
	mov_s r2,0x6
L_8e1cd0:
	stb_s r14,[r13,0x10]
L_8e1cd2:
	b.d L_8c0254
L_8e1cd6:
	mov_s r0,0x11
