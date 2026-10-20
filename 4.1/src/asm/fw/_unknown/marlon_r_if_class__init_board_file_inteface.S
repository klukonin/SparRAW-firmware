/* marlon_r_if_class__init_board_file_inteface @ 0x8d69bc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::init_board_file_inteface: Board file initialization error. RF configurations are not accessible. System will enter no RF flow
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r13_ret, abif__program_rf_clock_and_wait, fw_log__emit0, hwd_abif__program_rf_clk, hwd_rfc__program_clocks, hwf_rf__wait_reset_done, hwm_calib__set_loopback_mode, marlon_r_if_class__init_board_file_interface, rf__configure_chain
 */
	.section .text.marlon_r_if_class__init_board_file_inteface,"ax",@progbits
	.global marlon_r_if_class__init_board_file_inteface
marlon_r_if_class__init_board_file_inteface:
	.global L_8d69bc
L_8d69bc:
	push_s blink
L_8d69be:
	push_s r13
L_8d69c0:
	bl.d L_8cb9dc
L_8d69c4:
	mov_s r13,r0
L_8d69c6:
	bl.d L_8cba10
L_8d69ca:
	mov_s r0,0x1
L_8d69cc:
	bl.d L_8d4740
L_8d69d0:
	mov_s r0,0x0
L_8d69d2:
	bl.d L_8d4c0c
L_8d69d6:
	mov_s r0,0x1
L_8d69d8:
	bl.d L_8d4c0c
L_8d69dc:
	mov_s r0,0x0
L_8d69de:
	bl.d L_8d0394
L_8d69e2:
	mov_s r0,0x1
L_8d69e4:
	mov_s r0,0x0
L_8d69e6:
	bl.d L_8d46f4
L_8d69ea:
	mov_s r1,r0
L_8d69ec:
	bl.d L_8d66d8
L_8d69f0:
	mov_s r0,r13
L_8d69f2:
	brne_s r0,0,L_8d6a02
L_8d69f4:
	mov_s r2,0x1005d60
L_8d69fa:
	mov_s r0,0x0
L_8d69fc:
	bl.d L_8edfb0
L_8d6a00:
	mov_s r1,r0
	.global L_8d6a02
L_8d6a02:
	b L_8c033c
L_8d6a06:
	nop_s
