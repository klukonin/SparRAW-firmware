/* hwf_rf_xpm_single_byte_access_check_inputs @ 0x8f4c28, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_single_byte_access_check_inputs
 *   %s : <%s>=
 *   xpm_bit_address
 *   [NNL]=0x%x is out of valid XPM bit addresses range [0,0x%x]
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, hwf_rf_xpm_program_byte, hwf_rf_xpm_program_byte_8f4ab0, hwf_rf_xpm_read_byte
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2_tsf, fw_log_emit2, fw_sysassert_fatal, hwf_rf_check_rf_id
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm_single_byte_access_check_inputs
hwf_rf_xpm_single_byte_access_check_inputs:
	.global L_8f4c28
L_8f4c28:
	push_s blink
L_8f4c2a:
	bl L_8c01dc
L_8f4c2e:
	mov_s r16,r1
L_8f4c30:
	mov_s r15,r2
L_8f4c32:
	mov_s r14,0x101b5d4
L_8f4c38:
	bl.d L_8e2f18
L_8f4c3c:
	mov_s r1,r14
L_8f4c3e:
	brne r0,0x1,L_8f4c96
L_8f4c42:
	cmp r16,0x2000
L_8f4c4a:
	bcs.d L_8f4c8a
L_8f4c4e:
	mov_s r13,0x1
L_8f4c50:
	mov_s r1,0x101b600
L_8f4c56:
	mov_s r3,0x101b60c
L_8f4c5c:
	mov_s r13,0x0
L_8f4c5e:
	mov_s r0,r13
L_8f4c60:
	bl.d L_8dce04
L_8f4c64:
	mov_s r2,r14
L_8f4c66:
	mov_s r1,0x101b61c
L_8f4c6c:
	mov_s r0,r13
L_8f4c6e:
	mov_s r2,r16
L_8f4c70:
	mov_s r3,0x0
L_8f4c72:
	bl.d L_8dcc80
L_8f4c76:
	bset_s r3,r3,0xd
L_8f4c78:
	cmp_s r15,0x0
L_8f4c7a:
	mov.ne r0,blink
L_8f4c7e:
	mov.ne r1,0x155b
L_8f4c86:
	bl.ne L_8c9b28
	.global L_8f4c8a
L_8f4c8a:
	cmp_s r13,0x0
L_8f4c8c:
	mov_s r1,0x1
L_8f4c8e:
	sub_s.ne r1,r1,r1
L_8f4c90:
	mov_s r0,0x1
L_8f4c92:
	add1_s r0,r0,r1
L_8f4c94:
	b_s L_8f4c98
	.global L_8f4c96
L_8f4c96:
	mov_s r0,0x3
	.global L_8f4c98
L_8f4c98:
	b L_8c0244
