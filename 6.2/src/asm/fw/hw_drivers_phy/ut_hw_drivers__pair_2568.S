/* ut_hw_drivers__pair_2568 @ 0x8d2a50, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_phy__uses_rgf_883100, hwd_phy_rx_set_agc_start_val_and_gain_array
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers__pair_2568
ut_hw_drivers__pair_2568:
	.global L_8d2a50
L_8d2a50:
	push_s blink
L_8d2a52:
	push_s r13
L_8d2a54:
	bl.d L_8d2568
L_8d2a58:
	mov_s r5,r0
L_8d2a5a:
	mov_s r13,r0
L_8d2a5c:
	mov_s r0,r5
L_8d2a5e:
	bl.d L_8d2a6c
L_8d2a62:
	mov_s r1,r13
L_8d2a64:
	b.d L_8c025c
L_8d2a68:
	mov_s r0,r13
L_8d2a6a:
	nop_s
