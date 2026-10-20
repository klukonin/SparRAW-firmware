/* psc_if__copy_params @ 0x8e2278, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: psc_if__start_psc
 */
	.section .text.psc_if__copy_params,"ax",@progbits
	.global psc_if__copy_params
psc_if__copy_params:
	.global L_8e2278
L_8e2278:
	ld_s r2,[r1]
L_8e227a:
	ld_s r1,[r1,0x4]
L_8e227c:
	st_s r2,[r0,0x3c]
L_8e227e:
	j_s.d [blink]
L_8e2280:
	st_s r1,[r0,0x40]
L_8e2282:
	nop_s
