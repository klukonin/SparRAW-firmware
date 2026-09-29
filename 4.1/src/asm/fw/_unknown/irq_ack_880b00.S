/* irq_ack_880b00 @ 0x8e42f0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: set_reg_880200_8e42d8, tail_irq_ack_880b00
 */
	.section .text.irq_ack_880b00,"ax",@progbits
	.global irq_ack_880b00
irq_ack_880b00:
	.global L_8e42f0
L_8e42f0:
	mov_s r1,0x880b00
L_8e42f6:
	mov_s r2,0x4
L_8e42f8:
	breq_s r0,0,L_8e4300
L_8e42fa:
	st_s r2,[r1,0x50]
L_8e42fc:
	st_s r2,[r1,0x64]
L_8e42fe:
	b_s L_8e4302
	.global L_8e4300
L_8e4300:
	st_s r2,[r1,0x60]
	.global L_8e4302
L_8e4302:
	j_s [blink]
