/* ber_stats__snapshot @ 0x8f5a40, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ber_test__measure
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ber_stats__snapshot
ber_stats__snapshot:
	.global L_8f5a40
L_8f5a40:
	ld_s r1,[r0,0x18]
L_8f5a42:
	ld_s r2,[r0,0x28]
L_8f5a44:
	sub_s r1,r1,r2
L_8f5a46:
	st_s r1,[r0,0x2c]
L_8f5a48:
	ld_s r1,[r0,0x20]
L_8f5a4a:
	st_s r1,[r0,0x30]
L_8f5a4c:
	mov_s r1,0x0
L_8f5a4e:
	j_s.d [blink]
L_8f5a50:
	st_s r1,[r0,0x34]
L_8f5a52:
	nop_s
