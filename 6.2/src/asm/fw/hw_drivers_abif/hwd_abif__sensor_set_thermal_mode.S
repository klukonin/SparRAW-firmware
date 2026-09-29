/* hwd_abif__sensor_set_thermal_mode @ 0x8cfaac, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf__rf_lo_setup
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__sensor_set_thermal_mode
hwd_abif__sensor_set_thermal_mode:
	.global L_8cfaac
L_8cfaac:
	push_s blink
L_8cfaae:
	push_s r13
L_8cfab0:
	cmp_s r0,0x0
L_8cfab2:
	mov_s r13,0x1
L_8cfab4:
	sub_s.ne r13,r13,r13
L_8cfab6:
	mov_s r12,r13
L_8cfab8:
	bic.f r12,r12,-0xff
L_8cfabc:
	bne_s L_8cfad2
	.global L_8cfabe
L_8cfabe:
	mov_s r1,0x889300
L_8cfac4:
	ld_s r0,[r1,0x64]
L_8cfac6:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8cfac8:
	bclr_s r0,r0,0x4
L_8cfaca:
	or_s r13,r13,r0
L_8cfacc:
	st_s r13,[r1,0x64]
L_8cface:
	b L_8c025c
	.global L_8cfad2
L_8cfad2:
	mov_s r0,blink
L_8cfad4:
	bl.d L_8c9b28
L_8cfad8:
	mov_s r1,0xac
L_8cfada:
	b_s L_8cfabe
