/* rf_if__num_tx_sectors @ 0x8cb7e8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dmg_cap__build_sta_capability, marlon_r_if_class__init_board_file_interface
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_if__num_tx_sectors
rf_if__num_tx_sectors:
	.global L_8cb7e8
L_8cb7e8:
	ld_s r0,[r0,0x58]
L_8cb7ea:
	ld_s r1,[r0,0x44]
L_8cb7ec:
	ld_s r1,[r1,0x18]
L_8cb7ee:
	j_s [r1]
L_8cb7f0:
	j_s.d [blink]
L_8cb7f2:
	ldb r0,[r0, 0x40]
L_8cb7f6:
	nop_s
