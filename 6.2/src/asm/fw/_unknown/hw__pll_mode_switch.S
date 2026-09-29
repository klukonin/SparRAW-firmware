/* hw__pll_mode_switch @ 0x8d7c84, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: __ld_r13_to_r13_ret, hw_modes__enable_pll, hwm__reset_analog_block, mac__set_usec_clk_div
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw__pll_mode_switch
hw__pll_mode_switch:
	.global L_8d7c84
L_8d7c84:
	push_s blink
L_8d7c86:
	push_s r13
L_8d7c88:
	mov_s r13,r1
L_8d7c8a:
	brne r0,0x1,L_8d7cac
L_8d7c8e:
	breq_s r13,0,L_8d7ca6
L_8d7c90:
	mov_s r0,0x880a7c
L_8d7c96:
	ldw_s r0,[r0,0x10]
L_8d7c98:
	cmp_s r0,0x5
L_8d7c9a:
	mov_s r0,0x28
L_8d7c9c:
	mov.ne r0,0x26
L_8d7ca0:
	bl.d L_8e99dc
L_8d7ca4:
	mov_s r1,0x1
	.global L_8d7ca6
L_8d7ca6:
	bl L_8d772c
L_8d7caa:
	b_s L_8d7cc0
	.global L_8d7cac
L_8d7cac:
	bl L_8d7760
L_8d7cb0:
	cmp_s r13,0x0
L_8d7cb2:
	mov.ne r0,0xa5
L_8d7cba:
	bl.ne.d L_8e99dc
L_8d7cbe:
	sub_s.ne r1,r1,r1
	.global L_8d7cc0
L_8d7cc0:
	b L_8c025c
