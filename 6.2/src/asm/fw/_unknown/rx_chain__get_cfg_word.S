/* rx_chain__get_cfg_word @ 0x8cceb4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__ba_agreed
 * Глобалы (через gp): 0x80020c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_chain__get_cfg_word
rx_chain__get_cfg_word:
	.global L_8cceb4
L_8cceb4:
	j_s.d [blink]
L_8cceb6:
	ldw_s r0,[gp,0x88]
