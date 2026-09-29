/* ber_test__copy_counters @ 0x8ed830, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, ber_test__measure
 */
	.section .text.ber_test__copy_counters,"ax",@progbits
	.global ber_test__copy_counters
ber_test__copy_counters:
	.global L_8ed830
L_8ed830:
	ld_s r2,[r1,0x2c]
L_8ed832:
	ld_s r1,[r1,0x30]
L_8ed834:
	st_s r2,[r0]
L_8ed836:
	j_s.d [blink]
L_8ed838:
	st_s r1,[r0,0x4]
L_8ed83a:
	nop_s
