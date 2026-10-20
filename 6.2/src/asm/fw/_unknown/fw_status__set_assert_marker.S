/* fw_status__set_assert_marker @ 0x8e8640, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_status__set_assert_marker
fw_status__set_assert_marker:
	.global L_8e8640
L_8e8640:
	mov_s r1,0x880a3c
L_8e8646:
	j_s.d [blink]
L_8e8648:
	st_s r0,[r1,0xc]
L_8e864a:
	nop_s
