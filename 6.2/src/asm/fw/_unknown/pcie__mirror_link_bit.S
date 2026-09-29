/* pcie__mirror_link_bit @ 0x8d117c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_program_all
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__mirror_link_bit
pcie__mirror_link_bit:
	.global L_8d117c
L_8d117c:
	mov_s r1,0x882580
L_8d1182:
	ld_s r0,[r1,0x40]
L_8d1184:
	btst_s r0,0x0
L_8d1186:
	ld_s r0,[r1,0x3c]
L_8d1188:
	bset.ne r0,r0,0x9
L_8d118c:
	bclr.eq r0,r0,0x9
L_8d1190:
	st_s r0,[r1,0x3c]
L_8d1192:
	ld_s r0,[r1,0x3c]
L_8d1194:
	bclr_s r0,r0,0x15
L_8d1196:
	st_s r0,[r1,0x3c]
L_8d1198:
	mov_s r1,0x88b080
L_8d119e:
	ld_s r0,[r1,0x34]
L_8d11a0:
	bic r0,r0,0x78
L_8d11a4:
	st_s r0,[r1,0x34]
L_8d11a6:
	j_s [blink]
