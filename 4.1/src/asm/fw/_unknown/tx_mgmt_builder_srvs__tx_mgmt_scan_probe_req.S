/* tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req @ 0x8e4cbc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_mgmt_builder_srvs::tx_mgmt_scan_probe_req()
 * Зовут его: tx_probe__send_probe_req
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, memcpy_fw, mgmt_tx__build_probe_req
 */
	.section .text.tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req,"ax",@progbits
	.global tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req
tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req:
	.global L_8e4cbc
L_8e4cbc:
	push_s blink
L_8e4cbe:
	bl L_8c02b8
L_8e4cc2:
	mov_s r14,r0
L_8e4cc4:
	mov_s r17,r1
L_8e4cc6:
	mov_s r16,r2
L_8e4cc8:
	mov_s r15,r3
L_8e4cca:
	mov_s r13,r4
L_8e4ccc:
	mov_s r2,0x1010750
L_8e4cd2:
	mov_s r0,0xd
L_8e4cd4:
	bl.d L_8edfb0
L_8e4cd8:
	mov_s r1,0x2
L_8e4cda:
	ld r4,[r13, 0x8]
L_8e4cde:
	mov_s r0,r14
L_8e4ce0:
	ld r5,[r13, 0xc]
L_8e4ce4:
	mov_s r1,r17
L_8e4ce6:
	mov_s r2,r16
L_8e4ce8:
	bl.d L_8f1e78
L_8e4cec:
	mov_s r3,r15
L_8e4cee:
	ld_s r1,[r13]
L_8e4cf0:
	add_s r0,r14,0x4
L_8e4cf2:
	bl.d L_8c0460
L_8e4cf6:
	mov_s r2,0x6
L_8e4cf8:
	mov_s r0,0xff
L_8e4cfa:
	stb_s r0,[r14,0x10]
L_8e4cfc:
	stb_s r0,[r14,0x11]
L_8e4cfe:
	stb_s r0,[r14,0x12]
L_8e4d00:
	stb_s r0,[r14,0x13]
L_8e4d02:
	stb_s r0,[r14,0x14]
L_8e4d04:
	b.d L_8c031c
L_8e4d08:
	stb_s r0,[r14,0x15]
L_8e4d0a:
	nop_s
