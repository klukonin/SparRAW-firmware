/* pcie__mirror_link_bit @ 0x8ce438, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_program_all
 */
	.section .text.pcie__mirror_link_bit,"ax",@progbits
	.global pcie__mirror_link_bit
pcie__mirror_link_bit:
	.global L_8ce438
L_8ce438:
	mov_s r1,0x882580
L_8ce43e:
	ld_s r0,[r1,0x40]
L_8ce440:
	btst_s r0,0x0
L_8ce442:
	ld_s r0,[r1,0x3c]
L_8ce444:
	bset.ne r0,r0,0x9
L_8ce448:
	bclr.eq r0,r0,0x9
L_8ce44c:
	st_s r0,[r1,0x3c]
L_8ce44e:
	ld_s r0,[r1,0x3c]
L_8ce450:
	bclr_s r0,r0,0x15
L_8ce452:
	st_s r0,[r1,0x3c]
L_8ce454:
	mov_s r1,0x88b080
L_8ce45a:
	ld_s r0,[r1,0x34]
L_8ce45c:
	bic r0,r0,0x78
L_8ce460:
	st_s r0,[r1,0x34]
L_8ce462:
	j_s [blink]
