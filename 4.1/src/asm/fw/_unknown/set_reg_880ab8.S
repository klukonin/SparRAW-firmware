/* set_reg_880ab8 @ 0x8c918c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 */
	.section .text.set_reg_880ab8,"ax",@progbits
	.global set_reg_880ab8
set_reg_880ab8:
	.global L_8c918c
L_8c918c:
	mov_s r1,0x1
L_8c918e:
	mov_s r0,0x880a3c
L_8c9194:
	j_s.d [blink]
L_8c9196:
	st_s r1,[r0,0x7c]
