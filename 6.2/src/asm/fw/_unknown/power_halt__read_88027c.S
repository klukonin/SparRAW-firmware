/* power_halt__read_88027c @ 0x8da7f0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_halt__read_88027c
power_halt__read_88027c:
	.global L_8da7f0
L_8da7f0:
	mov_s r0,0x880200
L_8da7f6:
	ld_s r0,[r0,0x7c]
L_8da7f8:
	j_s [blink]
L_8da7fa:
	nop_s
