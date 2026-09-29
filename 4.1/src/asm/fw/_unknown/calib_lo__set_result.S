/* calib_lo__set_result @ 0x8ea598, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_lo_leakage_run
 */
	.section .text.calib_lo__set_result,"ax",@progbits
	.global calib_lo__set_result
calib_lo__set_result:
	.global L_8ea598
L_8ea598:
	st_s r1,[r0]
L_8ea59a:
	st_s r2,[r0,0x4]
L_8ea59c:
	st_s r3,[r0,0x8]
L_8ea59e:
	j_s.d [blink]
L_8ea5a0:
	st r4,[r0, 0xc]
