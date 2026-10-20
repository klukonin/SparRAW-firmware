/* qdesc_cfg__get_w14_field @ 0x8cc2fc, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__config_default_tx_ring, tx_queue__config_by_mode
 * Глобалы (через gp): 0x800200
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global qdesc_cfg__get_w14_field
qdesc_cfg__get_w14_field:
	.global L_8cc2fc
L_8cc2fc:
	j_s.d [blink]
L_8cc2fe:
	ldw_s r0,[gp,0x7c]
