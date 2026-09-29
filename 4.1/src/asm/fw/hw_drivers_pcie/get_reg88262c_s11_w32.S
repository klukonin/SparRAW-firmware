/* get_reg88262c_s11_w32 @ 0x8ce738, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_main
 */
	.section .text.get_reg88262c_s11_w32,"ax",@progbits
	.global get_reg88262c_s11_w32
get_reg88262c_s11_w32:
	.global L_8ce738
L_8ce738:
	mov_s r0,0x882600
L_8ce73e:
	ld_s r0,[r0,0x2c]
L_8ce740:
	lsr_s r0,r0,0xb
L_8ce742:
	j_s.d [blink]
L_8ce744:
	bmsk_s r0,r0,0x0
L_8ce746:
	nop_s
