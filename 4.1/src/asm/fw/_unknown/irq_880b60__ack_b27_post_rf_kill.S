/* irq_880b60__ack_b27_post_rf_kill @ 0x8cb590, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 * Зовёт сам: set_reg_880b00_8c1480, u_schd__schedule
 * Глобалы (через gp): 0x800438
 */
	.section .text.irq_880b60__ack_b27_post_rf_kill,"ax",@progbits
	.global irq_880b60__ack_b27_post_rf_kill
irq_880b60__ack_b27_post_rf_kill:
	.global L_8cb590
L_8cb590:
	push_s blink
L_8cb592:
	bl L_8c1480
L_8cb596:
	mov_s r0,0x1e9c0
L_8cb59c:
	ld.as r4,[gp,0xb2]
L_8cb5a0:
	mov_s r1,0x0
L_8cb5a2:
	mov_s r2,r1
L_8cb5a4:
	mov_s r3,r1
L_8cb5a6:
	mov_s r5,r1
L_8cb5a8:
	bl.d L_8dc92c
L_8cb5ac:
	mov_s r6,r1
L_8cb5ae:
	pop_s blink
