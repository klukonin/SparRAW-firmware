/* phy_stats__clear_counters_88395c @ 0x929cf8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_stats__accumulate_to_shared
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global phy_stats__clear_counters_88395c
phy_stats__clear_counters_88395c:
	.global L_929cf8
L_929cf8:
	mov_s r0,0x1
L_929cfa:
	st r0,[0x88395c]
L_929d02:
	j_s [blink]
