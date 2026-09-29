/* txq_cfg__c70_value_or_default @ 0x8cc308, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x8001fc, 0x800390
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global txq_cfg__c70_value_or_default
txq_cfg__c70_value_or_default:
	.global L_8cc308
L_8cc308:
	ld_s r0,[gp,0x20c]
L_8cc30a:
	mov_s r1,0xc8
L_8cc30c:
	cmp_s r0,0x0
L_8cc30e:
	mov.eq r0,r1
L_8cc312:
	beq_s L_8cc316
L_8cc314:
	ldw_s r0,[gp,0x78]
	.global L_8cc316
L_8cc316:
	j_s.d [blink]
L_8cc318:
	stw.as r0,[gp,0x3c]
