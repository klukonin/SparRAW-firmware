/* boot_uc__set_88000c @ 0x92a6e4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot_uc__init_g800610
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global boot_uc__set_88000c
boot_uc__set_88000c:
	.global L_92a6e4
L_92a6e4:
	st r0,[0x88000c]
L_92a6ec:
	j_s [blink]
L_92a6ee:
	nop_s
