/* pcie__dbi_set_data @ 0x8d1464, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__dbi_transfer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__dbi_set_data
pcie__dbi_set_data:
	.global L_8d1464
L_8d1464:
	mov_s r1,0x882600
L_8d146a:
	st_s r0,[r1,0x50]
L_8d146c:
	j_s [blink]
L_8d146e:
	nop_s
