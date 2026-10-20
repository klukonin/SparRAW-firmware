/* txq_cfg__default_1_if_unset @ 0x8ca0f8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x800380, 0x80038c
 */
	.section .text.txq_cfg__default_1_if_unset,"ax",@progbits
	.global txq_cfg__default_1_if_unset
txq_cfg__default_1_if_unset:
	.global L_8ca0f8
L_8ca0f8:
	ld_s r0,[gp,0x21c]
L_8ca0fa:
	mov_s r1,0x1
L_8ca0fc:
	cmp_s r0,0x0
L_8ca0fe:
	mov.eq r0,r1
L_8ca102:
	beq_s L_8ca106
L_8ca104:
	ld_s r0,[gp,0x210]
	.global L_8ca106
L_8ca106:
	j_s.d [blink]
L_8ca108:
	st.as r0,[gp,0x84]
