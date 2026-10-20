/* hwf__set_agc_index_1c @ 0x8e67a4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ber_test__measure, calib_lo_leakage__sweep
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_abif__caf_lpbk_mode, hwd_abif__tx_table_config_lo_leak_ctrl
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf__set_agc_index_1c
hwf__set_agc_index_1c:
	.global L_8e67a4
L_8e67a4:
	push_s blink
L_8e67a6:
	push_s r13
L_8e67a8:
	mov_s r13,r1
L_8e67aa:
	extb_s r2,r2
L_8e67ac:
	mov_s r0,0x1c
L_8e67ae:
	bl.d L_8cfd50
L_8e67b2:
	mov_s r1,0x1
L_8e67b4:
	extb_s r2,r13
L_8e67b6:
	mov_s r0,0x1c
L_8e67b8:
	bl.d L_8cfd50
L_8e67bc:
	mov_s r1,0x0
L_8e67be:
	bl.d L_8ce5e8
L_8e67c2:
	mov_s r0,0x0
L_8e67c4:
	bl.d L_8ce5e8
L_8e67c8:
	mov_s r0,0x1
L_8e67ca:
	b L_8c025c
L_8e67ce:
	nop_s
