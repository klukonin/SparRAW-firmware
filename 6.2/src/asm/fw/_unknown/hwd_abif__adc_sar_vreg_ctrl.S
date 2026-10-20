/* hwd_abif__adc_sar_vreg_ctrl @ 0x8ce518, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__adc_sar_vreg_ctrl
hwd_abif__adc_sar_vreg_ctrl:
	.global L_8ce518
L_8ce518:
	mov_s r1,0x88af00
L_8ce51e:
	cmp_s r0,0x1
L_8ce520:
	ld_s r0,[r1,0x48]
L_8ce522:
	bic r0,r0,0x1f
L_8ce526:
	bset.eq r0,r0,0x3
L_8ce52a:
	bset.ne r0,r0,0x4
L_8ce52e:
	st_s r0,[r1,0x48]
L_8ce530:
	j_s [blink]
L_8ce532:
	nop_s
