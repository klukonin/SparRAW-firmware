/* rf__is_present @ 0x8da5d8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__hw_ready_for_wmi, hwf_rf_check_rf_id, marlon_r_if_class__config_channel, marlon_r_if_class__rf_configure_role_power, temp_sense__no_rf, txrx_sel
 * Зовёт сам: rf__type_is_known
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__is_present
rf__is_present:
	.global L_8da5d8
L_8da5d8:
	push_s blink
L_8da5da:
	mov_s r0,0x880a3c
L_8da5e0:
	ld_s r0,[r0,0x2c]
L_8da5e2:
	mov_s r1,0x0
L_8da5e4:
	brne_s r0,0,L_8da5ec
L_8da5e6:
	bl L_8da5c4
L_8da5ea:
	brne_s r0,0,L_8da5f0
	.global L_8da5ec
L_8da5ec:
	mov_s r0,r1
L_8da5ee:
	b_s L_8da5f2
	.global L_8da5f0
L_8da5f0:
	mov_s r0,0x1
	.global L_8da5f2
L_8da5f2:
	extb_s r0,r0
L_8da5f4:
	pop_s blink
L_8da5f6:
	j_s [blink]
