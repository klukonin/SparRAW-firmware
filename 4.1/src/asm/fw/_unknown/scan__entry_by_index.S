/* scan__entry_by_index @ 0x8ebd04, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: scan_mngr__init
 */
	.section .text.scan__entry_by_index,"ax",@progbits
	.global scan__entry_by_index
scan__entry_by_index:
	.global L_8ebd04
L_8ebd04:
	asl_s r1,r0,0x3
L_8ebd06:
	add3_s r1,r1,r1
L_8ebd08:
	add r0,r1,0x842f60
L_8ebd10:
	j_s [blink]
L_8ebd12:
	nop_s
