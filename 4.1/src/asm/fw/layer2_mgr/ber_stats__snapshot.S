/* ber_stats__snapshot @ 0x8ed5b8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, ber_test__measure
 */
	.section .text.ber_stats__snapshot,"ax",@progbits
	.global ber_stats__snapshot
ber_stats__snapshot:
	.global L_8ed5b8
L_8ed5b8:
	ld_s r1,[r0,0x18]
L_8ed5ba:
	ld_s r2,[r0,0x28]
L_8ed5bc:
	sub_s r1,r1,r2
L_8ed5be:
	st_s r1,[r0,0x2c]
L_8ed5c0:
	ld_s r1,[r0,0x20]
L_8ed5c2:
	st_s r1,[r0,0x30]
L_8ed5c4:
	mov_s r1,0x0
L_8ed5c6:
	j_s.d [blink]
L_8ed5c8:
	st_s r1,[r0,0x34]
L_8ed5ca:
	nop_s
