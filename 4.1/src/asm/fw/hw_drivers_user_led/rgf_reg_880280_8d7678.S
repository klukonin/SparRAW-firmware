/* rgf_reg_880280_8d7678 @ 0x8d7678, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.rgf_reg_880280_8d7678,"ax",@progbits
	.global rgf_reg_880280_8d7678
rgf_reg_880280_8d7678:
	.global L_8d7678
L_8d7678:
	mov_s r1,0x880280
L_8d767e:
	ld_s r0,[r1]
L_8d7680:
	bclr_s r0,r0,0x2
L_8d7682:
	or r0,r0,0x48
L_8d7686:
	st_s r0,[r1]
L_8d7688:
	ld_s r0,[r1]
L_8d768a:
	bclr_s r0,r0,0x3
L_8d768c:
	st_s r0,[r1]
L_8d768e:
	j_s [blink]
