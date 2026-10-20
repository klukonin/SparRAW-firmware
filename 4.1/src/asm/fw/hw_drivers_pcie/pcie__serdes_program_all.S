/* pcie__serdes_program_all @ 0x8cea38, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_init
 * Зовёт сам: hwd_pcie__clear_88b000_bits, hwd_pcie__rgf_880c00, hwd_pcie__rgf_882f80_8cec98, pcie__l1ss_enable, pcie__mirror_link_bit
 */
	.section .text.pcie__serdes_program_all,"ax",@progbits
	.global pcie__serdes_program_all
pcie__serdes_program_all:
	.global L_8cea38
L_8cea38:
	push_s blink
L_8cea3a:
	bl L_8cea54
L_8cea3e:
	bl L_8ceab8
L_8cea42:
	bl L_8cea7c
L_8cea46:
	bl L_8cec98
L_8cea4a:
	bl L_8ce438
L_8cea4e:
	pop_s blink
L_8cea50:
	j_s [blink]
L_8cea52:
	nop_s
