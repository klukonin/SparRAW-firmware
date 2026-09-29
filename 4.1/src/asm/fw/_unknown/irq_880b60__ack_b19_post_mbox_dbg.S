/* irq_880b60__ack_b19_post_mbox_dbg @ 0x8cb460, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 * Зовёт сам: u_schd__add
 * Глобалы (через gp): 0x80031c
 */
	.section .text.irq_880b60__ack_b19_post_mbox_dbg,"ax",@progbits
	.global irq_880b60__ack_b19_post_mbox_dbg
irq_880b60__ack_b19_post_mbox_dbg:
	.global L_8cb460
L_8cb460:
	ld_s r0,[gp,0x1ac]
L_8cb462:
	mov_s r1,0x0
L_8cb464:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb466:
	st.as r0,[gp,0x6b]
L_8cb46a:
	mov_s r0,0x880b00
L_8cb470:
	st 0x80000,[r0, 0x60]
L_8cb478:
	mov_s r0,0x1ed5c
L_8cb47e:
	mov_s r2,r1
L_8cb480:
	b.d L_8c2ac8
L_8cb484:
	mov_s r3,0x1
L_8cb486:
	nop_s
