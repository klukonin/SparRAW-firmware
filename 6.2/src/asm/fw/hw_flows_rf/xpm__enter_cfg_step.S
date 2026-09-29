/* xpm__enter_cfg_step @ 0x8f4960, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_enter_cfg_mode_check_inputs
 *   %s : Value <%s>=
 *   cfg_mode
 *   [NNL]%d is out valid range [%d,%d]
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, hwf_rf_xpm_enter_cfg_mode
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2_tsf, fw_log_emit3, fw_sysassert_fatal, hwf_rf_check_rf_id
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__enter_cfg_step
xpm__enter_cfg_step:
	.global L_8f4960
L_8f4960:
	push_s blink
L_8f4962:
	bl L_8c01dc
L_8f4966:
	mov_s r14,r1
L_8f4968:
	mov_s r15,r2
L_8f496a:
	mov_s r1,0x101bc0c
L_8f4970:
	bl.d L_8e2f18
L_8f4974:
	mov_s r16,r1
L_8f4976:
	brne r0,0x1,L_8f49cc
L_8f497a:
	brhs.d r14,0x2,L_8f4984
L_8f497e:
	mov_s r13,0x1
L_8f4980:
	brge r14,0x0,L_8f49c0
	.global L_8f4984
L_8f4984:
	mov_s r1,0x101b680
L_8f498a:
	mov_s r3,0x101bc34
L_8f4990:
	mov_s r13,0x0
L_8f4992:
	mov_s r0,r13
L_8f4994:
	bl.d L_8dce04
L_8f4998:
	mov_s r2,r16
L_8f499a:
	mov_s r1,0x101b6a0
L_8f49a0:
	mov_s r0,r13
L_8f49a2:
	mov_s r2,r14
L_8f49a4:
	mov_s r3,r13
L_8f49a6:
	bl.d L_8dcd00
L_8f49aa:
	mov r4,0x1
L_8f49ae:
	cmp_s r15,0x0
L_8f49b0:
	mov.ne r0,blink
L_8f49b4:
	mov.ne r1,0x155f
L_8f49bc:
	bl.ne L_8c9b28
	.global L_8f49c0
L_8f49c0:
	cmp_s r13,0x0
L_8f49c2:
	mov_s r1,0x1
L_8f49c4:
	sub_s.ne r1,r1,r1
L_8f49c6:
	mov_s r0,0x1
L_8f49c8:
	add1_s r0,r0,r1
L_8f49ca:
	b_s L_8f49ce
	.global L_8f49cc
L_8f49cc:
	mov_s r0,0x3
	.global L_8f49ce
L_8f49ce:
	b L_8c0244
L_8f49d2:
	nop_s
