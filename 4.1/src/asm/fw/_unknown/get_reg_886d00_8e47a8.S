/* get_reg_886d00_8e47a8 @ 0x8e47a8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: psc__read_mac_counters
 */
	.section .text.get_reg_886d00_8e47a8,"ax",@progbits
	.global get_reg_886d00_8e47a8
get_reg_886d00_8e47a8:
	.global L_8e47a8
L_8e47a8:
	mov_s r0,0x886d00
L_8e47ae:
	ld_s r0,[r0,0x64]
L_8e47b0:
	j_s.d [blink]
L_8e47b2:
	extw_s r0,r0
