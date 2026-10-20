/* qdesc_cfg__is_override @ 0x8cc2e8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: qdesc__build_by_type, rf_chain__program_sector_desc, rx_chain__build_desc, rx_chain__build_desc_b, tx_queue__config_by_mode
 * Глобалы (через gp): 0x800394
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global qdesc_cfg__is_override
qdesc_cfg__is_override:
	.global L_8cc2e8
L_8cc2e8:
	j_s.d [blink]
L_8cc2ea:
	ld_s r0,[gp,0x210]
