/* hwm__set_analog_path @ 0x8d7528, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_corr__estimate_and_apply_rx_gain, hwf_calib__release_hw, hwf_calib__restore_path
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_abif__caf_lpbk_mode, hwd_abif__lpbk_mode_switches_config, hwd_abif__txrx_table_index_lpbk_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm__set_analog_path
hwm__set_analog_path:
	.global L_8d7528
L_8d7528:
	push_s blink
L_8d752a:
	push_s r13
L_8d752c:
	mov_s r13,r0
L_8d752e:
	mov_s r0,r1
L_8d7530:
	bl.d L_8cff68
L_8d7534:
	mov_s r1,r2
L_8d7536:
	breq_s r13,0,L_8d754a
L_8d7538:
	mov_s r0,0x3
L_8d753a:
	mov_s r1,r0
L_8d753c:
	bl.d L_8ceb2c
L_8d7540:
	mov_s r2,0x0
L_8d7542:
	bl.d L_8ce5e8
L_8d7546:
	mov_s r0,0x1
L_8d7548:
	b_s L_8d755a
	.global L_8d754a
L_8d754a:
	bl.d L_8ce5e8
L_8d754e:
	mov_s r0,0x0
L_8d7550:
	mov_s r0,0x3
L_8d7552:
	mov_s r1,0x2
L_8d7554:
	bl.d L_8ceb2c
L_8d7558:
	mov_s r2,0x0
	.global L_8d755a
L_8d755a:
	b L_8c025c
L_8d755e:
	nop_s
