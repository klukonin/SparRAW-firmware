/* set_reg_882650 @ 0x8ce768, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__dbi_transfer
 */
	.section .text.set_reg_882650,"ax",@progbits
	.global set_reg_882650
set_reg_882650:
	.global L_8ce768
L_8ce768:
	mov_s r1,0x882600
L_8ce76e:
	st_s r0,[r1,0x50]
L_8ce770:
	j_s [blink]
L_8ce772:
	nop_s
