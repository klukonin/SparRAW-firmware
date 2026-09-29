/* ber_test__copy_counters @ 0x8f5cd0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ber_test__measure
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ber_test__copy_counters
ber_test__copy_counters:
	.global L_8f5cd0
L_8f5cd0:
	ld_s r2,[r1,0x2c]
L_8f5cd2:
	ld_s r1,[r1,0x30]
L_8f5cd4:
	st_s r2,[r0]
L_8f5cd6:
	j_s.d [blink]
L_8f5cd8:
	st_s r1,[r0,0x4]
L_8f5cda:
	nop_s
