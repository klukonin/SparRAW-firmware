/* psc__store_time64 @ 0x8e7394, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: psc_if__start_psc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global psc__store_time64
psc__store_time64:
	.global L_8e7394
L_8e7394:
	ld_s r2,[r1]
L_8e7396:
	ld_s r1,[r1,0x4]
L_8e7398:
	st_s r2,[r0,0x18]
L_8e739a:
	j_s.d [blink]
L_8e739c:
	st_s r1,[r0,0x1c]
L_8e739e:
	nop_s
