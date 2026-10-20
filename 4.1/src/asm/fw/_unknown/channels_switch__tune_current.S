/* channels_switch__tune_current @ 0x8efbf0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: radio_vtbl__call_tune
 */
	.section .text.channels_switch__tune_current,"ax",@progbits
	.global channels_switch__tune_current
channels_switch__tune_current:
	.byte 0x0f
	.byte 0xe8
	.global sub_8efbf2
sub_8efbf2:
L_8efbf2:
	nop_s
L_8efbf4:
	ld_s r2,[r1,0x34]
L_8efbf6:
	ld_s r0,[r2,0x6c]
L_8efbf8:
	ldb r4,[r2, 0x10]
L_8efbfc:
	ldb r5,[r0, 0x10]
L_8efc00:
	mov_s r0,0x2a174
L_8efc06:
	ld_s r2,[r1,0x38]
L_8efc08:
	b.d L_8e0274
