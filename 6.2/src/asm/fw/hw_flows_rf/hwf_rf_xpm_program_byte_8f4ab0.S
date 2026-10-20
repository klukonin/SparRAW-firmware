/* hwf_rf_xpm_program_byte_8f4ab0 @ 0x8f4ab0, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_program_byte(): Start XPM byte programming: xpm_address=0x%x, byte_value=0x%x, max_trials_num=%d
 *   hwf_rf_xpm_program_byte(): XPM failed to program bit# %d from byte_value=0x%x at bit_address=0x%x
 *   hwf_rf_xpm_program_byte(): XPM Byte Write Verification failed for byte_address=0x%x, written_value=0x%x , read_value=0x%x
 *   hwf_rf_xpm_program_byte(): XPM Byte Write Verification failed due to XPM readout failure at byte_address=0x%x
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, hwf_rf_xpm_read_block
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log_emit1, fw_log_emit3, hwf_rf_xpm_program_byte, hwf_rf_xpm_read_byte, hwf_rf_xpm_single_byte_access_check_inputs
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm_program_byte_8f4ab0
hwf_rf_xpm_program_byte_8f4ab0:
	.global L_8f4ab0
L_8f4ab0:
	push_s blink
L_8f4ab2:
	bl L_8c01cc
L_8f4ab6:
	sub_s sp,sp,0x4
L_8f4ab8:
	mov_s r17,r0
L_8f4aba:
	mov_s r16,r1
L_8f4abc:
	mov_s r13,r2
L_8f4abe:
	mov_s r19,r3
L_8f4ac0:
	mov r18,r4
L_8f4ac4:
	mov r20,r5
L_8f4ac8:
	mov_s r1,0x101b858
L_8f4ace:
	mov_s r0,0x20
L_8f4ad0:
	mov_s r2,r16
L_8f4ad2:
	bl.d L_8dcd00
L_8f4ad6:
	mov_s r3,r13
L_8f4ad8:
	mov_s r0,r17
L_8f4ada:
	mov_s r1,r16
L_8f4adc:
	bl.d L_8f4c28
L_8f4ae0:
	mov_s r2,0x1
L_8f4ae2:
	brne r0,0x1,L_8f4b68
L_8f4ae6:
	bic r15,r16,0x7
L_8f4aea:
	mov_s r14,0x0
L_8f4aec:
	b_s L_8f4af2
	.global L_8f4aee
L_8f4aee:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8f4af0:
	extb_s r14,r14
	.global L_8f4af2
L_8f4af2:
	brge r14,0x8,L_8f4b26
L_8f4af6:
	bbit0 r13,r14,L_8f4aee
L_8f4afa:
	add r16,r14,r15
L_8f4afe:
	mov_s r0,r17
L_8f4b00:
	mov_s r1,r16
L_8f4b02:
	mov_s r2,r19
L_8f4b04:
	bl.d L_8f49d4
L_8f4b08:
	mov_s r3,r18
L_8f4b0a:
	brne_s r0,0,L_8f4aee
L_8f4b0c:
	mov_s r1,0x101b8c4
L_8f4b12:
	mov_s r15,0x0
L_8f4b14:
	mov_s r0,r15
L_8f4b16:
	mov_s r2,r14
L_8f4b18:
	mov_s r3,r13
L_8f4b1a:
	bl.d L_8dcd00
L_8f4b1e:
	mov r4,r16
L_8f4b22:
	mov_s r0,r15
L_8f4b24:
	b_s L_8f4b6a
	.global L_8f4b26
L_8f4b26:
	mov_s r14,0x1
L_8f4b28:
	breq r20,0x0,L_8f4b44
L_8f4b2c:
	mov_s r0,0x0
L_8f4b2e:
	stb_s r0,[sp,0x0]
L_8f4b30:
	mov_s r2,sp
L_8f4b32:
	mov_s r0,r17
L_8f4b34:
	bl.d L_8f4bd8
L_8f4b38:
	mov_s r1,r15
L_8f4b3a:
	breq_s r0,0,L_8f4b5a
L_8f4b3c:
	ldb r4,[sp]
L_8f4b40:
	brne r13,r4,L_8f4b48
	.global L_8f4b44
L_8f4b44:
	mov_s r0,r14
L_8f4b46:
	b_s L_8f4b6a
	.global L_8f4b48
L_8f4b48:
	mov_s r1,0x101b928
L_8f4b4e:
	mov_s r0,0x0
L_8f4b50:
	mov_s r2,r15
L_8f4b52:
	bl.d L_8dcd00
L_8f4b56:
	mov_s r3,r13
L_8f4b58:
	b_s L_8f4b68
	.global L_8f4b5a
L_8f4b5a:
	mov_s r1,0x101b9a4
L_8f4b60:
	mov_s r0,0x0
L_8f4b62:
	bl.d L_8dcc10
L_8f4b66:
	mov_s r2,r15
	.global L_8f4b68
L_8f4b68:
	mov_s r0,0x0
	.global L_8f4b6a
L_8f4b6a:
	b.d L_8c0224
L_8f4b6e:
	add_s sp,sp,0x4
