/* pcie__dbi_set_addr @ 0x8d1220, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__dbi_read, pcie__dbi_transfer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__dbi_set_addr
pcie__dbi_set_addr:
	.global L_8d1220
L_8d1220:
	mov_s r1,0x882600
L_8d1226:
	st_s r0,[r1,0x4c]
L_8d1228:
	j_s [blink]
L_8d122a:
	nop_s
