/* softfloat_double_to_short_b @ 0x9210d4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw
 * Зовёт сам: softfloat_double_to_short
 */
	.section .text.softfloat_double_to_short_b,"ax",@progbits
	.global softfloat_double_to_short_b
softfloat_double_to_short_b:
	.global L_9210d4
L_9210d4:
	asl.f r3,r1
L_9210d8:
	mov r4,0xb
L_9210dc:
	bcc.d L_9210f0
L_9210e0:
	not r2,0x0
