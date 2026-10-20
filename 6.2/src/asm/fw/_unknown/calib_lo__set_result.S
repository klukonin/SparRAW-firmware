/* calib_lo__set_result @ 0x8f1d08, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_leakage__sweep
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_lo__set_result
calib_lo__set_result:
	.global L_8f1d08
L_8f1d08:
	st_s r1,[r0]
L_8f1d0a:
	st_s r2,[r0,0x4]
L_8f1d0c:
	st_s r3,[r0,0x8]
L_8f1d0e:
	j_s.d [blink]
L_8f1d10:
	st r4,[r0, 0xc]
