/* phy_stats__get_cfg_word @ 0x8d25c0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_stats__dump
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy_stats__get_cfg_word
phy_stats__get_cfg_word:
	.global L_8d25c0
L_8d25c0:
	mov_s r0,0x800524
L_8d25c6:
	j_s.d [blink]
L_8d25c8:
	ld_s r0,[r0]
L_8d25ca:
	nop_s
