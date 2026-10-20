/* hwf_if_gain__apply_agc_table @ 0x8d5f08, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: if_gain
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_abif__rx_table_config_ifrx_ctrl, hwd_abif__tx_table_config_iftx_ctrl
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_if_gain__apply_agc_table
hwf_if_gain__apply_agc_table:
	.global L_8d5f08
L_8d5f08:
	push_s blink
L_8d5f0a:
	bl.d L_8c01dc
L_8d5f0e:
	mov_s r1,0x1
L_8d5f10:
	mov_s r15,r0
L_8d5f12:
	add1 r13,r0,r0
L_8d5f16:
	add_s r13,r13,0x80197c
L_8d5f1c:
	mov_s r0,0x0
L_8d5f1e:
	bl.d L_8cfcb4
L_8d5f22:
	ldb_s r2,[r13]
L_8d5f24:
	mov_s r0,0x0
L_8d5f26:
	mov_s r1,0x2
L_8d5f28:
	bl.d L_8cfcb4
L_8d5f2c:
	ldb_s r2,[r13,0x1]
L_8d5f2e:
	mov_s r0,0x0
L_8d5f30:
	mov_s r1,0x3
L_8d5f32:
	bl.d L_8cfcb4
L_8d5f36:
	ldb_s r2,[r13,0x2]
L_8d5f38:
	mov r16,0x3f
L_8d5f3c:
	mov_s r14,0x1
	.global L_8d5f3e
L_8d5f3e:
	add1 r13,r15,r15
L_8d5f42:
	add_s r13,r13,0x80197c
L_8d5f48:
	mov_s r0,r14
L_8d5f4a:
	mov_s r1,0x1
L_8d5f4c:
	bl.d L_8cf0f8
L_8d5f50:
	ldb_s r2,[r13]
L_8d5f52:
	mov_s r0,r14
L_8d5f54:
	mov_s r1,0x2
L_8d5f56:
	bl.d L_8cf0f8
L_8d5f5a:
	ldb_s r2,[r13,0x1]
L_8d5f5c:
	mov_s r0,r14
L_8d5f5e:
	mov_s r1,0x3
L_8d5f60:
	bl.d L_8cf0f8
L_8d5f64:
	ldb_s r2,[r13,0x2]
L_8d5f66:
	sub r16,r16,0x1
L_8d5f6a:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d5f6c:
	brhs.d r16,0x1,L_8d5f3e
L_8d5f70:
	extb_s r14,r14
L_8d5f72:
	b L_8c0244
L_8d5f76:
	nop_s
