/* hwf_rf_xpm_read_block @ 0x8ec29c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_read_block(): XPM read failure from cur_xpm_addr=%d, byte_idx=%d of total num_bytes=%d
 * Зовут его: TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit3, hwf_rf_xpm_block_access_check_inputs, hwf_rf_xpm_read_byte
 */
	.section .text.hwf_rf_xpm_read_block,"ax",@progbits
	.global hwf_rf_xpm_read_block
hwf_rf_xpm_read_block:
	.global L_8ec29c
L_8ec29c:
	push_s blink
L_8ec29e:
	bl.d L_8c02b0
L_8ec2a2:
	mov_s r4,r2
L_8ec2a4:
	mov_s r19,r0
L_8ec2a6:
	mov_s r13,r1
L_8ec2a8:
	mov_s r18,r2
L_8ec2aa:
	mov_s r15,r3
L_8ec2ac:
	bl.d L_8ec190
L_8ec2b0:
	mov r5,0x1
L_8ec2b4:
	brne r0,0x1,L_8ec2e4
L_8ec2b8:
	brlo.d r18,0x1,L_8ec2e0
L_8ec2bc:
	mov_s r1,0x0
L_8ec2be:
	mov_s r0,r18
	.global L_8ec2c0
L_8ec2c0:
	mov_s r17,r1
L_8ec2c2:
	mov_s r16,r0
L_8ec2c4:
	add3 r14,r13,r1
L_8ec2c8:
	add_s r2,r1,r15
L_8ec2ca:
	mov_s r0,r19
L_8ec2cc:
	bl.d L_8ec308
L_8ec2d0:
	mov_s r1,r14
L_8ec2d2:
	breq_s r0,0,L_8ec2e8
L_8ec2d4:
	sub r0,r16,0x1
L_8ec2d8:
	brhs.d r0,0x1,L_8ec2c0
L_8ec2dc:
	add r1,r17,0x1
	.global L_8ec2e0
L_8ec2e0:
	mov_s r0,0x1
L_8ec2e2:
	b_s L_8ec304
	.global L_8ec2e4
L_8ec2e4:
	mov_s r0,0x0
L_8ec2e6:
	b_s L_8ec304
	.global L_8ec2e8
L_8ec2e8:
	mov_s r2,0x101713c
L_8ec2ee:
	mov_s r13,0x0
L_8ec2f0:
	mov_s r0,r13
L_8ec2f2:
	mov_s r1,r13
L_8ec2f4:
	mov_s r3,r14
L_8ec2f6:
	mov r4,r17
L_8ec2fa:
	bl.d L_8ee034
L_8ec2fe:
	mov r5,r18
L_8ec302:
	mov_s r0,r13
	.global L_8ec304
L_8ec304:
	b L_8c030c
