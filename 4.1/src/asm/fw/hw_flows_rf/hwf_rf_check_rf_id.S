/* hwf_rf_check_rf_id @ 0x8efcec, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Function %s:
 *   [NNL] invalid rf_id=%d (max=%d)
 *   hw_flows_rf.c
 * Зовут его: hwf_rf_xpm_block_access_check_inputs, hwf_rf_xpm_single_byte_access_check_inputs
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1_nonl, fw_log__emit2, fw_sysassert_fatal, rf__is_present
 */
	.section .text.hwf_rf_check_rf_id,"ax",@progbits
	.global hwf_rf_check_rf_id
hwf_rf_check_rf_id:
	.global L_8efcec
L_8efcec:
	push_s blink
L_8efcee:
	bl L_8c02bc
L_8efcf2:
	mov_s r14,r0
L_8efcf4:
	mov_s r16,r1
L_8efcf6:
	mov_s r15,r2
L_8efcf8:
	bl.d L_8d750c
L_8efcfc:
	mov_s r13,0x0
L_8efcfe:
	cmp_s r0,0x0
L_8efd00:
	mov.eq r0,r13
L_8efd04:
	beq_s L_8efd4a
L_8efd06:
	brlo.d r14,0x8,L_8efd4a
L_8efd0a:
	mov_s r0,0x1
L_8efd0c:
	mov_s r2,0x1016f48
L_8efd12:
	mov_s r0,r13
L_8efd14:
	mov_s r1,r13
L_8efd16:
	bl.d L_8ee080
L_8efd1a:
	mov_s r3,r16
L_8efd1c:
	mov_s r2,0x1016f58
L_8efd22:
	mov_s r0,r13
L_8efd24:
	mov_s r1,r13
L_8efd26:
	mov_s r3,r14
L_8efd28:
	bl.d L_8edff8
L_8efd2c:
	mov r4,0x8
L_8efd30:
	breq_s r15,0,L_8efd48
L_8efd32:
	mov_s r0,blink
L_8efd34:
	mov_s r2,0x1016c54
L_8efd3a:
	mov_s r1,0x155a
L_8efd40:
	bl.d L_8c82c0
L_8efd44:
	mov r3,0x179
	.global L_8efd48
L_8efd48:
	mov_s r0,0x3
	.global L_8efd4a
L_8efd4a:
	b L_8c0324
L_8efd4e:
	nop_s
