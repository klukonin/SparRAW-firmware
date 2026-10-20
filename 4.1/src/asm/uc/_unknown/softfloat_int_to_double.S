/* softfloat_int_to_double @ 0x920464, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_build_schedule_tables
 * Зовёт сам: softfloat_u32_to_double
 */
	.section .text.softfloat_int_to_double,"ax",@progbits
	.global softfloat_int_to_double
softfloat_int_to_double:
	.global L_920464
L_920464:
	mov_s r12,0x1
L_920466:
	mov.f r1,r0
L_92046a:
	add1.mi r12,r12,r12
L_92046e:
	b.d L_92047e
L_920472:
	rsub.mi r0,r0,0x0
L_920476:
	nop_s
