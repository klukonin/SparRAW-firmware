/* txq_cfg__default_40_if_unset @ 0x8ca10c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x8001e6, 0x800370
 */
	.section .text.txq_cfg__default_40_if_unset,"ax",@progbits
	.global txq_cfg__default_40_if_unset
txq_cfg__default_40_if_unset:
	.global L_8ca10c
L_8ca10c:
	ld_s r0,[gp,0x200]
L_8ca10e:
	mov_s r1,0x40
L_8ca110:
	cmp_s r0,0x0
L_8ca112:
	mov.eq r0,r1
L_8ca116:
	beq_s L_8ca11a
L_8ca118:
	ldw_s r0,[gp,0x76]
	.global L_8ca11a
L_8ca11a:
	j_s.d [blink]
L_8ca11c:
	stw.as r0,[gp,0x3b]
