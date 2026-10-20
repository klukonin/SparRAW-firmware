/* get_g_800374 @ 0x8ca0c4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain__program_sector_desc, rx_queue__config_by_kind, rx_queue__config_by_kind_b, tx_queue__config_by_mode, tx_queue__config_by_mode_b
 * Глобалы (через gp): 0x800374
 */
	.section .text.get_g_800374,"ax",@progbits
	.global get_g_800374
get_g_800374:
	.global L_8ca0c4
L_8ca0c4:
	j_s.d [blink]
L_8ca0c6:
	ld_s r0,[gp,0x204]
