/* hwd_pcie__rgf_882f80_8cec98 @ 0x8cec98, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_program_all
 */
	.section .text.hwd_pcie__rgf_882f80_8cec98,"ax",@progbits
	.global hwd_pcie__rgf_882f80_8cec98
hwd_pcie__rgf_882f80_8cec98:
	.global L_8cec98
L_8cec98:
	mov_s r1,0x882f80
L_8cec9e:
	ld_s r0,[r1,0x8]
L_8ceca0:
	bclr_s r0,r0,0x1d
L_8ceca2:
	st_s r0,[r1,0x8]
L_8ceca4:
	ld_s r0,[r1,0x8]
L_8ceca6:
	bclr_s r0,r0,0x1e
L_8ceca8:
	st_s r0,[r1,0x8]
L_8cecaa:
	j_s [blink]
