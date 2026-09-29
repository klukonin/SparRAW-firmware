/* hwd_abif__rfc_clk_ctrl @ 0x8ced74, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_abif__rfc_divider_restart, hwm_analog_channel_switch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rfc_clk_ctrl
hwd_abif__rfc_clk_ctrl:
	.global L_8ced74
L_8ced74:
	mov_s r1,0x889400
L_8ced7a:
	cmp_s r0,0x1
L_8ced7c:
	ld_s r0,[r1,0x1c]
L_8ced7e:
	bclr.eq r0,r0,0x3
L_8ced82:
	bset.ne r0,r0,0x3
L_8ced86:
	st_s r0,[r1,0x1c]
L_8ced88:
	j_s [blink]
L_8ced8a:
	nop_s
