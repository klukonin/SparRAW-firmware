/* mgmt_tx__build_mac_header @ 0x8ec5c0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__begin_frame, mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp, tx_mgmt_srvs__build_disassoc
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_hdr__copy_addr, memcpy_fw, mid__copy_bssid
 */
	.section .text.mgmt_tx__build_mac_header,"ax",@progbits
	.global mgmt_tx__build_mac_header
mgmt_tx__build_mac_header:
	.global L_8ec5c0
L_8ec5c0:
	push_s blink
L_8ec5c2:
	/* bl.d 0x008c02bc */
	.byte 0xfe,0x0c,0xef,0xe9
L_8ec5c6:
	/* _asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_8ec5c8:
	mov_s r15,r0
L_8ec5ca:
	mov_s r13,r1
L_8ec5cc:
	mov_s r1,r3
L_8ec5ce:
	add3 r16,r0,0x9
L_8ec5d2:
	stb_s r2,[r13]
L_8ec5d4:
	mov_s r14,0x0
L_8ec5d6:
	stb_s r14,[r13,0x1]
L_8ec5d8:
	stw_s r14,[r13,0x2]
L_8ec5da:
	add_s r0,r13,0x4
L_8ec5dc:
	bl.d L_8c0460
L_8ec5e0:
	mov_s r2,0x6
L_8ec5e2:
	add r1,r13,0xa
L_8ec5e6:
	bl.d L_8ca180
L_8ec5ea:
	mov_s r0,r15
L_8ec5ec:
	add r1,r13,0x10
L_8ec5f0:
	bl.d L_8c9ae4
L_8ec5f4:
	mov_s r0,r16
L_8ec5f6:
	b.d L_8c0324
L_8ec5fa:
	stw_s r14,[r13,0x16]
