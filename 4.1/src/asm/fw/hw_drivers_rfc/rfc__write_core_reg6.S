/* rfc__write_core_reg6 @ 0x8d042c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_analog_channel_switch
 * Зовёт сам: hwd_rfc_write_core
 */
	.section .text.rfc__write_core_reg6,"ax",@progbits
	.global rfc__write_core_reg6
rfc__write_core_reg6:
	.global L_8d042c
L_8d042c:
	bmsk r2,r1,0xe
L_8d0430:
	mov_s r1,0x6
L_8d0432:
	b.d L_8d0f80
L_8d0436:
	mov_s r3,0x0
