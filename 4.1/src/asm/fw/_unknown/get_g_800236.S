/* get_g_800236 @ 0x8c9898, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_ppdu_ageing_timeout_detector__task
 * Глобалы (через gp): 0x800236
 */
	.section .text.get_g_800236,"ax",@progbits
	.global get_g_800236
get_g_800236:
	.global L_8c9898
L_8c9898:
	j_s.d [blink]
L_8c989a:
	ldb_s r0,[gp,0xc6]
