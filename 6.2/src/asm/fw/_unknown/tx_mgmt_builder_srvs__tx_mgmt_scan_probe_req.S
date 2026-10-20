/* tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req @ 0x8ea054, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_mgmt_builder_srvs::tx_mgmt_scan_probe_req()
 * Зовут его: tx_probe__send_probe_req
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit0, memcpy_fw, mgmt_tx__build_probe_req
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req
tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req:
	.global L_8ea054
L_8ea054:
	push_s blink
L_8ea056:
	bl L_8c01d8
L_8ea05a:
	mov_s r14,r0
L_8ea05c:
	mov_s r17,r1
L_8ea05e:
	mov_s r16,r2
L_8ea060:
	mov_s r15,r3
L_8ea062:
	mov_s r13,r4
L_8ea064:
	mov_s r1,0x1013c20
L_8ea06a:
	bl.d L_8dcba8
L_8ea06e:
	mov_s r0,0x2d
L_8ea070:
	ld r4,[r13, 0x8]
L_8ea074:
	mov_s r0,r14
L_8ea076:
	ld r5,[r13, 0xc]
L_8ea07a:
	mov_s r1,r17
L_8ea07c:
	mov_s r2,r16
L_8ea07e:
	bl.d L_8e9ebc
L_8ea082:
	mov_s r3,r15
L_8ea084:
	ld_s r1,[r13]
L_8ea086:
	add_s r0,r14,0x4
L_8ea088:
	bl.d L_8c0380
L_8ea08c:
	mov_s r2,0x6
L_8ea08e:
	mov_s r0,0xff
L_8ea090:
	stb_s r0,[r14,0x10]
L_8ea092:
	stb_s r0,[r14,0x11]
L_8ea094:
	stb_s r0,[r14,0x12]
L_8ea096:
	stb_s r0,[r14,0x13]
L_8ea098:
	stb_s r0,[r14,0x14]
L_8ea09a:
	b.d L_8c023c
L_8ea09e:
	stb_s r0,[r14,0x15]
