/* push_cap_info @ 0x8e1d78, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   push_cap_info: >>>>>> with BSS TYPE = 0x%x and PRIVACY = 0x%x <<<<<
 * Зовут его: frame_builder__assoc_resp_fix_fields, mgmt_tx__assoc_req_fixed_fields, mgmt_tx__build_assoc_resp, mgmt_tx__copy_ie_hdr
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global push_cap_info
push_cap_info:
	.global L_8e1d78
L_8e1d78:
	push_s blink
L_8e1d7a:
	bl L_8c01e4
L_8e1d7e:
	mov_s r14,r0
L_8e1d80:
	mov_s r13,r1
L_8e1d82:
	ldb_s r2,[r13]
L_8e1d84:
	mov_s r1,0x100faac
L_8e1d8a:
	lsr r3,r2,0x4
L_8e1d8e:
	mov_s r0,0x2d
L_8e1d90:
	bmsk_s r2,r2,0x1
L_8e1d92:
	bl.d L_8dcc80
L_8e1d96:
	bmsk_s r3,r3,0x0
L_8e1d98:
	mov_s r0,r14
L_8e1d9a:
	mov_s r1,r13
L_8e1d9c:
	bl.d L_8c0380
L_8e1da0:
	mov_s r2,0x2
L_8e1da2:
	b.d L_8c0254
L_8e1da6:
	mov_s r0,0x2
