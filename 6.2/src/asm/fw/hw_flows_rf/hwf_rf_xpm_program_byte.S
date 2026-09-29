/* hwf_rf_xpm_program_byte @ 0x8f49d4, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_program_byte(): XPM bit program failed for xpm_bit_address=0x%x, trial %d of %d
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, hwf_rf_xpm_program_byte_8f4ab0
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3, hwd_rfc_xpm_get_write_status, hwf_rf_xpm_single_byte_access_check_inputs, rfc__write_core_c_flag
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm_program_byte
hwf_rf_xpm_program_byte:
	.global L_8f49d4
L_8f49d4:
	push_s blink
L_8f49d6:
	bl L_8c01d4
L_8f49da:
	mov_s r15,r0
L_8f49dc:
	mov_s r16,r1
L_8f49de:
	mov_s r18,r2
L_8f49e0:
	mov_s r17,r3
L_8f49e2:
	mov_s r13,0x1
L_8f49e4:
	bl.d L_8f4c28
L_8f49e8:
	mov_s r2,r13
L_8f49ea:
	cmp_s r0,0x1
L_8f49ec:
	mov_s r0,0x0
L_8f49ee:
	bne_s L_8f4a2c
L_8f49f0:
	brlo r17,0x1,L_8f4a2c
L_8f49f4:
	mov_s r14,r17
	.global L_8f49f6
L_8f49f6:
	mov_s r0,r15
L_8f49f8:
	mov_s r1,r16
L_8f49fa:
	bl.d L_8d460c
L_8f49fe:
	mov_s r2,0x1
L_8f4a00:
	mov_s r0,r15
L_8f4a02:
	bl.d L_8d4564
L_8f4a06:
	mov_s r1,r18
L_8f4a08:
	brne_s r0,0,L_8f4a2a
L_8f4a0a:
	mov_s r1,0x101b7fc
L_8f4a10:
	mov_s r0,0x0
L_8f4a12:
	mov_s r2,r16
L_8f4a14:
	mov_s r3,r13
L_8f4a16:
	bl.d L_8dcd00
L_8f4a1a:
	mov r4,r17
L_8f4a1e:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8f4a20:
	brhs.d r14,0x1,L_8f49f6
L_8f4a24:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f4a26:
	mov_s r0,0x0
L_8f4a28:
	b_s L_8f4a2c
	.global L_8f4a2a
L_8f4a2a:
	mov_s r0,0x1
	.global L_8f4a2c
L_8f4a2c:
	b L_8c0234
