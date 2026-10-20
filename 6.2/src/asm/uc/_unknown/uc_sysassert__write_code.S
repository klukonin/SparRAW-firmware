/* uc_sysassert__write_code @ 0x929d04, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_sysassert__write_code
uc_sysassert__write_code:
	.global L_929d04
L_929d04:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_929d06:
	st r0,[0x884804]
L_929d0e:
	j_s [blink]
