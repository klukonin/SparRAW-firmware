/* qdesc_cfg__get_w4_field @ 0x8cc300, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x80023d
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global qdesc_cfg__get_w4_field
qdesc_cfg__get_w4_field:
	.global L_8cc300
L_8cc300:
	j_s.d [blink]
L_8cc302:
	ldb_s r0,[gp,0xb9]
