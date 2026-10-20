/* temp__get_rf_by_index @ 0x8cca40, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: basic_calib_sparrow__estimation_alg, calib__classify_by_thresholds, link_lost_diag_part2, wmi__cmd_arg_check
 * Зовёт сам: __ld_r13_to_r13_ret, fw_divmod_signed, temp__get_active_rf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global temp__get_rf_by_index
temp__get_rf_by_index:
	.global L_8cca40
L_8cca40:
	push_s blink
L_8cca42:
	push_s r13
L_8cca44:
	cmp r0,0xff
L_8cca48:
	mov_s r13,r1
L_8cca4a:
	mov r1,-0x1
L_8cca4e:
	bne_s L_8cca58
L_8cca50:
	bl.d L_8ccbf4
L_8cca54:
	mov_s r0,0x0
L_8cca56:
	b_s L_8cca6a
	.global L_8cca58
L_8cca58:
	cmp_s r0,0x8
L_8cca5a:
	mov.cc r0,r1
L_8cca5e:
	bhs_s L_8cca6a
L_8cca60:
	mov_s r1,0x847fa8
L_8cca66:
	ld.as r0,[r1,r0]
	.global L_8cca6a
L_8cca6a:
	brne r13,0x1,L_8cca7e
L_8cca6e:
	cmp r0,-0x1
L_8cca72:
	mov.ne r1,0x3e8
L_8cca7a:
	bl.ne L_8c02dc
	.global L_8cca7e
L_8cca7e:
	b L_8c025c
L_8cca82:
	nop_s
