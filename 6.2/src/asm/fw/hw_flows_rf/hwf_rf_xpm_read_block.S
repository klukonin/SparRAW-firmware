/* hwf_rf_xpm_read_block @ 0x8f4a30, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_read_block(): XPM failed to program byte at xpm_byte_address=0x%x, byte_idx=%d of total num_bytes=%d
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, host_if__write_rf_xpm_handler
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, fw_log_emit3, hwf_rf_xpm_block_access_check_inputs, hwf_rf_xpm_program_byte_8f4ab0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm_read_block
hwf_rf_xpm_read_block:
	.global L_8f4a30
L_8f4a30:
	push_s blink
L_8f4a32:
	bl L_8c01c4
L_8f4a36:
	mov_s r20,r0
L_8f4a38:
	mov_s r18,r1
L_8f4a3a:
	mov_s r19,r2
L_8f4a3c:
	mov_s r15,r3
L_8f4a3e:
	mov r16,r4
L_8f4a42:
	mov r22,r5
L_8f4a46:
	mov r21,r6
L_8f4a4a:
	mov_s r4,r2
L_8f4a4c:
	bl.d L_8f46f4
L_8f4a50:
	mov r5,0x1
L_8f4a54:
	brne r0,0x1,L_8f4a8e
L_8f4a58:
	bic r18,r18,0x7
L_8f4a5c:
	brlo.d r19,0x1,L_8f4a8a
L_8f4a60:
	mov_s r14,0x0
L_8f4a62:
	mov_s r0,r19
	.global L_8f4a64
L_8f4a64:
	mov_s r17,r0
L_8f4a66:
	add3 r13,r18,r14
L_8f4a6a:
	ldb_s r2,[r15,r14]
L_8f4a6c:
	mov_s r0,r20
L_8f4a6e:
	mov_s r1,r13
L_8f4a70:
	mov_s r3,r16
L_8f4a72:
	mov r4,r22
L_8f4a76:
	bl.d L_8f4ab0
L_8f4a7a:
	mov r5,r21
L_8f4a7e:
	breq_s r0,0,L_8f4a92
L_8f4a80:
	sub r0,r17,0x1
L_8f4a84:
	brhs.d r0,0x1,L_8f4a64
L_8f4a88:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8f4a8a
L_8f4a8a:
	mov_s r0,0x1
L_8f4a8c:
	b_s L_8f4aaa
	.global L_8f4a8e
L_8f4a8e:
	mov_s r0,0x0
L_8f4a90:
	b_s L_8f4aaa
	.global L_8f4a92
L_8f4a92:
	mov_s r1,0x101ba14
L_8f4a98:
	mov_s r15,0x0
L_8f4a9a:
	mov_s r0,r15
L_8f4a9c:
	mov_s r2,r13
L_8f4a9e:
	mov_s r3,r14
L_8f4aa0:
	bl.d L_8dcd00
L_8f4aa4:
	mov r4,r19
L_8f4aa8:
	mov_s r0,r15
	.global L_8f4aaa
L_8f4aaa:
	b L_8c0214
L_8f4aae:
	nop_s
