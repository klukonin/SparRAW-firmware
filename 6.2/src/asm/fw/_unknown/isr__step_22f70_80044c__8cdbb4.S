/* isr__step_22f70_80044c__8cdbb4 @ 0x8cdbb4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 * Зовёт сам: rf_kill__mask_irq, u_schd__schedule
 * Глобалы (через gp): 0x80044c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global isr__step_22f70_80044c__8cdbb4
isr__step_22f70_80044c__8cdbb4:
	.global L_8cdbb4
L_8cdbb4:
	push_s blink
L_8cdbb6:
	bl L_8c14bc
L_8cdbba:
	mov_s r0,L_8e2f70-0x8c0000
L_8cdbc0:
	ld.as r4,[gp,0xb2]
L_8cdbc4:
	mov_s r1,0x0
L_8cdbc6:
	mov_s r2,r1
L_8cdbc8:
	mov_s r3,r1
L_8cdbca:
	mov_s r5,r1
L_8cdbcc:
	bl.d L_8e0c0c
L_8cdbd0:
	mov_s r6,r1
L_8cdbd2:
	pop_s blink
L_8cdbd4:
	j_s [blink]
L_8cdbd6:
	nop_s
