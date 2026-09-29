/* get_reg_880b00_8d16dc @ 0x8d16dc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.get_reg_880b00_8d16dc,"ax",@progbits
	.global get_reg_880b00_8d16dc
get_reg_880b00_8d16dc:
	.global L_8d16dc
L_8d16dc:
	mov_s r0,0x880b00
L_8d16e2:
	ld_s r0,[r0,0x54]
L_8d16e4:
	sub.f r0,r0,0x0
L_8d16e8:
	j_s.d [blink]
L_8d16ea:
	mov.ne r0,0x1
L_8d16ee:
	nop_s
