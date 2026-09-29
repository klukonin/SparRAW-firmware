/* qdesc_cfg__get_w10_field @ 0x8cc2f0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x80029c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global qdesc_cfg__get_w10_field
qdesc_cfg__get_w10_field:
	.global L_8cc2f0
L_8cc2f0:
	j_s.d [blink]
L_8cc2f2:
	ldw_s r0,[gp,0x118]
