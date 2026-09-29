/* lmac_if__get_evt_byte3 @ 0x8cb910, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_ppdu_ageing_timeout_detector__task
 * Глобалы (через gp): 0x80024d
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__get_evt_byte3
lmac_if__get_evt_byte3:
	.global L_8cb910
L_8cb910:
	j_s.d [blink]
L_8cb912:
	ldb_s r0,[gp,0xc9]
