/* txq_cfg__default_c8_if_unset @ 0x8ca0e4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x8001e4, 0x800370
 */
	.section .text.txq_cfg__default_c8_if_unset,"ax",@progbits
	.global txq_cfg__default_c8_if_unset
txq_cfg__default_c8_if_unset:
	.global L_8ca0e4
L_8ca0e4:
	ld_s r0,[gp,0x200]
L_8ca0e6:
	mov_s r1,0xc8
L_8ca0e8:
	cmp_s r0,0x0
L_8ca0ea:
	mov.eq r0,r1
L_8ca0ee:
	beq_s L_8ca0f2
L_8ca0f0:
	ldw_s r0,[gp,0x74]
	.global L_8ca0f2
L_8ca0f2:
	j_s.d [blink]
L_8ca0f4:
	stw.as r0,[gp,0x3a]
