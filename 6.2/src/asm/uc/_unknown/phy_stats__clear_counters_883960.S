/* phy_stats__clear_counters_883960 @ 0x929cec, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_stats__accumulate_to_shared, rx__check_mode_2, ucode_cmd_0x37_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global phy_stats__clear_counters_883960
phy_stats__clear_counters_883960:
	.global L_929cec
L_929cec:
	mov_s r0,0x1
L_929cee:
	st r0,[0x883960]
L_929cf6:
	j_s [blink]
