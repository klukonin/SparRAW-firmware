/* rf__is_present @ 0x8d750c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__hw_ready_for_wmi, hwf_rf_check_rf_id, marlon_r_if_class__config_channel, marlon_r_if_class__rf_configure_role_power, temp_sense__no_rf, txrx_sel
 * Зовёт сам: get_reg_880a7c
 */
	.section .text.rf__is_present,"ax",@progbits
	.global rf__is_present
rf__is_present:
	.global L_8d750c
L_8d750c:
	push_s blink
L_8d750e:
	mov_s r0,0x880a3c
L_8d7514:
	ld_s r0,[r0,0x2c]
L_8d7516:
	mov_s r1,0x0
L_8d7518:
	brne_s r0,0,L_8d7520
L_8d751a:
	bl L_8d74f8
L_8d751e:
	brne_s r0,0,L_8d7524
	.global L_8d7520
L_8d7520:
	mov_s r0,r1
L_8d7522:
	b_s L_8d7526
	.global L_8d7524
L_8d7524:
	mov_s r0,0x1
	.global L_8d7526
L_8d7526:
	extb_s r0,r0
L_8d7528:
	pop_s blink
L_8d752a:
	j_s [blink]
