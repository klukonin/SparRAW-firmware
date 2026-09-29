/* hwf_rf_xpm_read_block_8f4b70 @ 0x8f4b70, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_read_block(): XPM read failure from cur_xpm_addr=%d, byte_idx=%d of total num_bytes=%d
 * Зовут его: TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters, UT_HW_FLOWS_OPERATIONAL_cmd_handler, host_if__read_rf_xpm_handler, hwf_rf_xpm__read_block_8b
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit3, hwf_rf_xpm_block_access_check_inputs, hwf_rf_xpm_read_byte
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm_read_block_8f4b70
hwf_rf_xpm_read_block_8f4b70:
	.global L_8f4b70
L_8f4b70:
	push_s blink
L_8f4b72:
	bl.d L_8c01d0
L_8f4b76:
	mov_s r4,r2
L_8f4b78:
	mov_s r19,r0
L_8f4b7a:
	mov_s r15,r1
L_8f4b7c:
	mov_s r18,r2
L_8f4b7e:
	mov_s r16,r3
L_8f4b80:
	bl.d L_8f46f4
L_8f4b84:
	mov r5,0x1
L_8f4b88:
	brne r0,0x1,L_8f4bb6
L_8f4b8c:
	brlo.d r18,0x1,L_8f4bb2
L_8f4b90:
	mov_s r13,0x0
L_8f4b92:
	mov_s r0,r18
	.global L_8f4b94
L_8f4b94:
	mov_s r17,r0
L_8f4b96:
	add3 r14,r15,r13
L_8f4b9a:
	add r2,r13,r16
L_8f4b9e:
	mov_s r0,r19
L_8f4ba0:
	bl.d L_8f4bd8
L_8f4ba4:
	mov_s r1,r14
L_8f4ba6:
	breq_s r0,0,L_8f4bba
L_8f4ba8:
	sub r0,r17,0x1
L_8f4bac:
	brhs.d r0,0x1,L_8f4b94
L_8f4bb0:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8f4bb2
L_8f4bb2:
	mov_s r0,0x1
L_8f4bb4:
	b_s L_8f4bd2
	.global L_8f4bb6
L_8f4bb6:
	mov_s r0,0x0
L_8f4bb8:
	b_s L_8f4bd2
	.global L_8f4bba
L_8f4bba:
	mov_s r1,0x101b798
L_8f4bc0:
	mov_s r15,0x0
L_8f4bc2:
	mov_s r0,r15
L_8f4bc4:
	mov_s r2,r14
L_8f4bc6:
	mov_s r3,r13
L_8f4bc8:
	bl.d L_8dcd00
L_8f4bcc:
	mov r4,r18
L_8f4bd0:
	mov_s r0,r15
	.global L_8f4bd2
L_8f4bd2:
	b L_8c022c
L_8f4bd6:
	nop_s
