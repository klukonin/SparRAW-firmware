/* field_bit2 @ 0x8d6f1c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: irq_cause__bit2
 */
	.section .text.field_bit2,"ax",@progbits
	.global field_bit2
field_bit2:
	.global L_8d6f1c
L_8d6f1c:
	lsr r0,r1,0x2
L_8d6f20:
	j_s.d [blink]
L_8d6f22:
	bmsk_s r0,r0,0x0
