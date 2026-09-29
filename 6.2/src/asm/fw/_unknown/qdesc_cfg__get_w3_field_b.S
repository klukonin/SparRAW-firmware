/* qdesc_cfg__get_w3_field_b @ 0x8cc2f8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x80023e
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global qdesc_cfg__get_w3_field_b
qdesc_cfg__get_w3_field_b:
	.global L_8cc2f8
L_8cc2f8:
	j_s.d [blink]
L_8cc2fa:
	ldb_s r0,[gp,0xba]
