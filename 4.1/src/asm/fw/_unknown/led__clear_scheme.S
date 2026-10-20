/* led__clear_scheme @ 0x8d77d0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: user_led__set_pattern
 * Глобалы (через gp): 0x80039c
 */
	.section .text.led__clear_scheme,"ax",@progbits
	.global led__clear_scheme
led__clear_scheme:
L_8d77d0:
	mov_s r0,0x8004d4
L_8d77d6:
	mov_s r1,0x0
L_8d77d8:
	st_s r1,[r0]
L_8d77da:
	ld_s r0,[gp,0x22c]
L_8d77dc:
	b.d L_8d7694
L_8d77e0:
	mov_s r2,0x64
L_8d77e2:
	nop_s
