/* hwf_rf_xpm_read_byte @ 0x8f4bd8, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_read_byte(): xpm read success xpm_address=0x%x, xpm_read_value=0x%x
 *   hwf_rf_xpm_read_byte(): Failed to read byte from xpm_address=0x%x, xpm_read_value_out=0x%x
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, hwf_rf_xpm_program_byte_8f4ab0, hwf_rf_xpm_read_block_8f4b70
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit2, hwf_rf_xpm_single_byte_access_check_inputs, xpm__read_data_byte
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm_read_byte
hwf_rf_xpm_read_byte:
	.global L_8f4bd8
L_8f4bd8:
	push_s blink
L_8f4bda:
	bl L_8c01d8
L_8f4bde:
	mov_s r13,r0
L_8f4be0:
	mov_s r17,r1
L_8f4be2:
	mov_s r14,r2
L_8f4be4:
	mov_s r15,0x1
L_8f4be6:
	bl.d L_8f4c28
L_8f4bea:
	mov_s r2,r15
L_8f4bec:
	cmp_s r0,0x1
L_8f4bee:
	mov_s r0,0x0
L_8f4bf0:
	bne_s L_8f4c24
L_8f4bf2:
	mov_s r16,r0
L_8f4bf4:
	extb_s r0,r13
L_8f4bf6:
	mov_s r1,r17
L_8f4bf8:
	bl.d L_8d45e0
L_8f4bfc:
	mov_s r2,r14
L_8f4bfe:
	ldb_s r3,[r14]
L_8f4c00:
	breq_s r0,0,L_8f4c14
L_8f4c02:
	mov_s r1,0x101b6ec
L_8f4c08:
	mov_s r0,0x20
L_8f4c0a:
	bl.d L_8dcc80
L_8f4c0e:
	mov_s r2,r17
L_8f4c10:
	mov_s r0,r15
L_8f4c12:
	b_s L_8f4c24
	.global L_8f4c14
L_8f4c14:
	mov_s r1,0x101b73c
L_8f4c1a:
	mov_s r0,r16
L_8f4c1c:
	bl.d L_8dcc80
L_8f4c20:
	mov_s r2,r17
L_8f4c22:
	mov_s r0,r16
	.global L_8f4c24
L_8f4c24:
	b L_8c023c
