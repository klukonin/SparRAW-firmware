/* txq_cfg__c74_value_or_default @ 0x8cc330, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x8001fe, 0x800390
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global txq_cfg__c74_value_or_default
txq_cfg__c74_value_or_default:
	.global L_8cc330
L_8cc330:
	ld_s r0,[gp,0x20c]
L_8cc332:
	mov_s r1,0x40
L_8cc334:
	cmp_s r0,0x0
L_8cc336:
	mov.eq r0,r1
L_8cc33a:
	beq_s L_8cc33e
L_8cc33c:
	ldw_s r0,[gp,0x7a]
	.global L_8cc33e
L_8cc33e:
	j_s.d [blink]
L_8cc340:
	stw.as r0,[gp,0x3d]
