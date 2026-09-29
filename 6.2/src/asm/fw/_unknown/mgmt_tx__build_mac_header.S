/* mgmt_tx__build_mac_header @ 0x8d7db8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__begin_frame, mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp_8f9e88, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp, tx_mgmt_srvs__build_disassoc
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_hdr__copy_addr, memcpy_fw, mid__copy_bssid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__build_mac_header
mgmt_tx__build_mac_header:
	.global L_8d7db8
L_8d7db8:
	push_s blink
L_8d7dba:
	bl.d L_8c01dc
L_8d7dbe:
	/* _asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_8d7dc0:
	mov_s r15,r0
L_8d7dc2:
	mov_s r13,r1
L_8d7dc4:
	mov_s r1,r3
L_8d7dc6:
	add3 r16,r0,0x9
L_8d7dca:
	stb_s r2,[r13]
L_8d7dcc:
	mov_s r14,0x0
L_8d7dce:
	stb_s r14,[r13,0x1]
L_8d7dd0:
	stw_s r14,[r13,0x2]
L_8d7dd2:
	add_s r0,r13,0x4
L_8d7dd4:
	bl.d L_8c0380
L_8d7dd8:
	mov_s r2,0x6
L_8d7dda:
	add r1,r13,0xa
L_8d7dde:
	bl.d L_8cc3ac
L_8d7de2:
	mov_s r0,r15
L_8d7de4:
	add r1,r13,0x10
L_8d7de8:
	bl.d L_8cbb58
L_8d7dec:
	mov_s r0,r16
L_8d7dee:
	b.d L_8c0244
L_8d7df2:
	stw_s r14,[r13,0x16]
