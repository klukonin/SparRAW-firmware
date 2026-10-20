/* irq_cause__bit2 @ 0x8e4668, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 * Зовёт сам: field_bit2
 */
	.section .text.irq_cause__bit2,"ax",@progbits
	.global irq_cause__bit2
irq_cause__bit2:
	.global L_8e4668
L_8e4668:
	mov_s r1,r0
L_8e466a:
	b.d L_8d6f1c
L_8e466e:
	add_s r0,gp,0x70
