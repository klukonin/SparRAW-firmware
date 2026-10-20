/* hwf_rf_check_rf_id @ 0x8e2f18, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Function %s:
 *   [NNL] invalid rf_id=%d (max=%d)
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, hwf_rf_xpm_block_access_check_inputs, hwf_rf_xpm_single_byte_access_check_inputs, xpm__enter_cfg_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1_tsf, fw_log_emit2, fw_sysassert_fatal, rf__is_present
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_check_rf_id
hwf_rf_check_rf_id:
	.global L_8e2f18
L_8e2f18:
	push_s blink
L_8e2f1a:
	bl L_8c01dc
L_8e2f1e:
	mov_s r14,r0
L_8e2f20:
	mov_s r16,r1
L_8e2f22:
	mov_s r15,r2
L_8e2f24:
	bl.d L_8da5d8
L_8e2f28:
	mov_s r13,0x0
L_8e2f2a:
	cmp_s r0,0x0
L_8e2f2c:
	mov.eq r0,r13
L_8e2f30:
	beq_s L_8e2f6a
L_8e2f32:
	brlo.d r14,0x8,L_8e2f6a
L_8e2f36:
	mov_s r0,0x1
L_8e2f38:
	mov_s r1,0x101cf18
L_8e2f3e:
	mov_s r0,r13
L_8e2f40:
	bl.d L_8dcd90
L_8e2f44:
	mov_s r2,r16
L_8e2f46:
	mov_s r1,0x101cf28
L_8e2f4c:
	mov_s r0,r13
L_8e2f4e:
	mov_s r2,r14
L_8e2f50:
	bl.d L_8dcc80
L_8e2f54:
	mov_s r3,0x8
L_8e2f56:
	cmp_s r15,0x0
L_8e2f58:
	mov.ne r0,blink
L_8e2f5c:
	mov.ne r1,0x155a
L_8e2f64:
	bl.ne L_8c9b28
L_8e2f68:
	mov_s r0,0x3
	.global L_8e2f6a
L_8e2f6a:
	b L_8c0244
L_8e2f6e:
	nop_s
