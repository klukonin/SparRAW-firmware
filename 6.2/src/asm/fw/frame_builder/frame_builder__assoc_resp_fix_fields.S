/* frame_builder__assoc_resp_fix_fields @ 0x8f4f20, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC RESP fix fields are built
 * Зовут его: mgmt_tx__build_assoc_resp_8f9e88
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_sysassert_fatal, memcpy_fw, push_cap_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global frame_builder__assoc_resp_fix_fields
frame_builder__assoc_resp_fix_fields:
	.global L_8f4f20
L_8f4f20:
	push_s blink
L_8f4f22:
	bl L_8c01dc
L_8f4f26:
	sub_s sp,sp,0x4
L_8f4f28:
	mov_s r14,r0
L_8f4f2a:
	mov_s r13,r1
L_8f4f2c:
	mov_s r15,r2
L_8f4f2e:
	mov_s r1,0x1010120
L_8f4f34:
	bl.d L_8dcba8
L_8f4f38:
	mov_s r0,0x2d
L_8f4f3a:
	add2 r1,r13,0x17
L_8f4f3e:
	bl.d L_8e1d78
L_8f4f42:
	mov_s r0,r14
L_8f4f44:
	extw r16,r0
L_8f4f48:
	ldw.as r0,[r15,0x8c]
L_8f4f4c:
	add r13,r16,r14
L_8f4f50:
	stw r0,[sp]
L_8f4f54:
	mov_s r0,r13
L_8f4f56:
	mov_s r1,sp
L_8f4f58:
	bl.d L_8c0380
L_8f4f5c:
	mov_s r2,0x2
L_8f4f5e:
	add_s r0,r13,0x2
L_8f4f60:
	add r16,r16,0x2
L_8f4f64:
	ldb_s r1,[r15,0x8]
L_8f4f66:
	extw r16,r16
L_8f4f6a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8f4f6c:
	stw r1,[sp, 0x2]
L_8f4f70:
	add r1,sp,0x2
L_8f4f74:
	bl.d L_8c0380
L_8f4f78:
	mov_s r2,0x2
L_8f4f7a:
	/* add_s r13,0x4 */
	.byte 0x04,0xe5
L_8f4f7c:
	add r15,r16,0x2
L_8f4f80:
	extw_s r15,r15
L_8f4f82:
	sub_s r13,r13,r14
L_8f4f84:
	brne r15,r13,L_8f4f90
	.global L_8f4f88
L_8f4f88:
	mov_s r0,r15
L_8f4f8a:
	b.d L_8c0244
L_8f4f8e:
	add_s sp,sp,0x4
	.global L_8f4f90
L_8f4f90:
	mov_s r0,blink
L_8f4f92:
	mov_s r1,0x11d3
L_8f4f98:
	bl L_8c9b28
L_8f4f9c:
	b_s L_8f4f88
L_8f4f9e:
	nop_s
