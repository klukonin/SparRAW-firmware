/* set_reg_884804 @ 0x9274e4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_sysassert
 */
	.section .text.set_reg_884804,"ax",@progbits
	.global set_reg_884804
set_reg_884804:
	.global L_9274e4
L_9274e4:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9274e6:
	st r0,[0x884804]
L_9274ee:
	j_s [blink]
