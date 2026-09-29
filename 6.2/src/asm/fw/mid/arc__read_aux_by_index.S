/* arc__read_aux_by_index @ 0x8c3b5c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: instruction_error__report
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global arc__read_aux_by_index
arc__read_aux_by_index:
	.global L_8c3b5c
L_8c3b5c:
	add1_s r0,r0,r0
L_8c3b5e:
	add r0,r0,0x220
L_8c3b62:
	j_s.d [blink]
L_8c3b64:
	lr r0,[r0]
