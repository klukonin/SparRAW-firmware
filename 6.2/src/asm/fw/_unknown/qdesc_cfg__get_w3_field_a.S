/* qdesc_cfg__get_w3_field_a @ 0x8cc2f4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x80023c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global qdesc_cfg__get_w3_field_a
qdesc_cfg__get_w3_field_a:
	.global L_8cc2f4
L_8cc2f4:
	j_s.d [blink]
L_8cc2f6:
	ldb_s r0,[gp,0xb8]
