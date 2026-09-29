/* hwd_pcie__clear_88b000_bits @ 0x8cea7c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_program_all
 */
	.section .text.hwd_pcie__clear_88b000_bits,"ax",@progbits
	.global hwd_pcie__clear_88b000_bits
hwd_pcie__clear_88b000_bits:
	.global L_8cea7c
L_8cea7c:
	mov_s r1,0x88b000
L_8cea82:
	ld_s r0,[r1,0x2c]
L_8cea84:
	mov_s r2,0x882500
L_8cea8a:
	bclr_s r0,r0,0x3
L_8cea8c:
	st_s r0,[r1,0x2c]
L_8cea8e:
	ld r0,[r1, 0xb0]
L_8cea92:
	bclr_s r0,r0,0x2
L_8cea94:
	st r0,[r1, 0xb0]
L_8cea98:
	mov_s r1,0x882000
L_8cea9e:
	ld_s r0,[r1]
L_8ceaa0:
	bclr_s r0,r0,0x1c
L_8ceaa2:
	st_s r0,[r1]
L_8ceaa4:
	ld_s r0,[r2,0x54]
L_8ceaa6:
	bclr_s r0,r0,0x12
L_8ceaa8:
	st_s r0,[r2,0x54]
L_8ceaaa:
	ld_s r0,[r1,0x24]
L_8ceaac:
	bclr_s r0,r0,0x1b
L_8ceaae:
	st_s r0,[r1,0x24]
L_8ceab0:
	ld_s r0,[r2,0x60]
L_8ceab2:
	bclr_s r0,r0,0x3
L_8ceab4:
	st_s r0,[r2,0x60]
L_8ceab6:
	j_s [blink]
