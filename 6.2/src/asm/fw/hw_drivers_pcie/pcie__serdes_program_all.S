/* pcie__serdes_program_all @ 0x8d1720, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_init
 * Зовёт сам: hwd_pcie__clear_88b000_bits, hwd_pcie__rgf_882f80_8d196c, hwd_pcie__uses_rgf_880c00, pcie__l1ss_enable, pcie__mirror_link_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__serdes_program_all
pcie__serdes_program_all:
	.global L_8d1720
L_8d1720:
	push_s blink
L_8d1722:
	bl L_8d173c
L_8d1726:
	bl L_8d17a0
L_8d172a:
	bl L_8d1764
L_8d172e:
	bl L_8d196c
L_8d1732:
	bl L_8d117c
L_8d1736:
	pop_s blink
L_8d1738:
	j_s [blink]
L_8d173a:
	nop_s
