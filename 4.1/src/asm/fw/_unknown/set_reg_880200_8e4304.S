/* set_reg_880200_8e4304 @ 0x8e4304, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power__enter_halt
 */
	.section .text.set_reg_880200_8e4304,"ax",@progbits
	.global set_reg_880200_8e4304
set_reg_880200_8e4304:
	.global L_8e4304
L_8e4304:
	push_s blink
L_8e4306:
	mov_s r1,0x880200
L_8e430c:
	st_s r0,[r1,0x8]
L_8e430e:
	mov_s r0,0x65
L_8e4310:
	st_s r0,[r1,0x24]
L_8e4312:
	sync
L_8e4316:
	pop_s blink
L_8e4318:
	j_s [blink]
L_8e431a:
	nop_s
