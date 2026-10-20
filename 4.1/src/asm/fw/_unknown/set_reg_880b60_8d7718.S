/* set_reg_880b60_8d7718 @ 0x8d7718, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 */
	.section .text.set_reg_880b60_8d7718,"ax",@progbits
	.global set_reg_880b60_8d7718
set_reg_880b60_8d7718:
	.global L_8d7718
L_8d7718:
	mov_s r1,0x10
L_8d771a:
	mov_s r0,0x880b00
L_8d7720:
	st_s r1,[r0,0x60]
L_8d7722:
	j_s [blink]
