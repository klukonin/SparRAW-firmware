/* hwf_rf_xpm_enter_cfg_mode @ 0x8f491c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_enter_cfg_mode(): Failed to find configuration preset for requested cfg_mode=%d
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, hwf_rf_xpm_cfg_set, xpm__enter_cfg_step, xpm__get_cfg_preset
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm_enter_cfg_mode
hwf_rf_xpm_enter_cfg_mode:
	.global L_8f491c
L_8f491c:
	push_s blink
L_8f491e:
	bl L_8c01e0
L_8f4922:
	mov_s r15,r0
L_8f4924:
	mov_s r14,r1
L_8f4926:
	mov_s r13,0x1
L_8f4928:
	bl.d L_8f4960
L_8f492c:
	mov_s r2,r13
L_8f492e:
	brne r0,0x1,L_8f4950
L_8f4932:
	bl.d L_8d336c
L_8f4936:
	mov_s r0,r14
L_8f4938:
	mov.f r1,r0
L_8f493c:
	bne_s L_8f4954
L_8f493e:
	mov_s r1,0x101bc40
L_8f4944:
	mov_s r13,0x0
L_8f4946:
	mov_s r0,r13
L_8f4948:
	bl.d L_8dcc10
L_8f494c:
	mov_s r2,r14
L_8f494e:
	b_s L_8f495a
	.global L_8f4950
L_8f4950:
	mov_s r13,0x0
L_8f4952:
	b_s L_8f495a
	.global L_8f4954
L_8f4954:
	bl.d L_8f4890
L_8f4958:
	mov_s r0,r15
	.global L_8f495a
L_8f495a:
	b.d L_8c024c
L_8f495e:
	mov_s r0,r13
