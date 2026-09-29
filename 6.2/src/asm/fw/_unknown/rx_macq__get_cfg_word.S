/* rx_macq__get_cfg_word @ 0x8cc3c4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__setup
 * Глобалы (через gp): 0x8003dc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__get_cfg_word
rx_macq__get_cfg_word:
	.global L_8cc3c4
L_8cc3c4:
	j_s.d [blink]
L_8cc3c6:
	ld_s r0,[gp,0x258]
