/* qdesc_cfg__get_w13_field @ 0x8cc344, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x800202
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global qdesc_cfg__get_w13_field
qdesc_cfg__get_w13_field:
	.global L_8cc344
L_8cc344:
	j_s.d [blink]
L_8cc346:
	ldw_s r0,[gp,0x7e]
