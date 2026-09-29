/* rfc_field_write @ 0x8d4308, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd__program_rf_regs_seq, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, hwd_rfc_write_verify, hwm_analog_channel_switch, marlon_r_if_class__config_brp_sectors, marlon_r_if_class__rf_hw_write_buffer
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc_field_write
rfc_field_write:
	.global L_8d4308
L_8d4308:
	push_s blink
L_8d430a:
	bl L_8c01e4
L_8d430e:
	mov_s r13,r1
L_8d4310:
	cmp_s r1,0x7fff
L_8d4316:
	mov_s r14,r2
L_8d4318:
	bhi_s L_8d432a
	.global L_8d431a
L_8d431a:
	mov_s r0,0x0
L_8d431c:
	mov_s r1,r0
L_8d431e:
	mov_s r2,r13
L_8d4320:
	bl.d L_8d415c
L_8d4324:
	mov_s r3,r14
L_8d4326:
	b L_8c0254
	.global L_8d432a
L_8d432a:
	mov_s r0,blink
L_8d432c:
	mov_s r1,0x1142
L_8d4332:
	bl L_8c9b28
L_8d4336:
	b_s L_8d431a
