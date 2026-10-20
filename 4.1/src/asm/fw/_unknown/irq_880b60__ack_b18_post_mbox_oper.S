/* irq_880b60__ack_b18_post_mbox_oper @ 0x8cb440, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 * Зовёт сам: u_schd__add
 */
	.section .text.irq_880b60__ack_b18_post_mbox_oper,"ax",@progbits
	.global irq_880b60__ack_b18_post_mbox_oper
irq_880b60__ack_b18_post_mbox_oper:
	.global L_8cb440
L_8cb440:
	mov_s r0,0x880b00
L_8cb446:
	st 0x40000,[r0, 0x60]
L_8cb44e:
	mov_s r0,0x1ed20
L_8cb454:
	mov_s r1,0x0
L_8cb456:
	mov_s r2,r1
L_8cb458:
	b.d L_8c2ac8
L_8cb45c:
	mov_s r3,0x1
L_8cb45e:
	nop_s
