/* arc__read_aux_by_index @ 0x8e96dc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: instruction_error__report
 */
	.section .text.arc__read_aux_by_index,"ax",@progbits
	.global arc__read_aux_by_index
arc__read_aux_by_index:
	.global L_8e96dc
L_8e96dc:
	add1_s r0,r0,r0
L_8e96de:
	add r0,r0,0x220
L_8e96e2:
	j_s.d [blink]
L_8e96e4:
	lr r0,[r0]
