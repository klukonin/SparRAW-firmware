/* txq_cfg__default_0_if_unset @ 0x8ca124, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x8001ec, 0x800370
 */
	.section .text.txq_cfg__default_0_if_unset,"ax",@progbits
	.global txq_cfg__default_0_if_unset
txq_cfg__default_0_if_unset:
	.global L_8ca124
L_8ca124:
	ld_s r0,[gp,0x200]
L_8ca126:
	mov_s r1,0x0
L_8ca128:
	cmp_s r0,0x0
L_8ca12a:
	mov.eq r0,r1
L_8ca12e:
	beq_s L_8ca132
L_8ca130:
	ldw_s r0,[gp,0x7c]
	.global L_8ca132
L_8ca132:
	j_s.d [blink]
L_8ca134:
	stw.as r0,[gp,0x3e]
