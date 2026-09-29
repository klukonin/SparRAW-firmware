/* hwd_pcie__clear_88b000_bits @ 0x8d1764, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_program_all
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__clear_88b000_bits
hwd_pcie__clear_88b000_bits:
	.global L_8d1764
L_8d1764:
	mov_s r1,0x88b000
L_8d176a:
	ld_s r0,[r1,0x2c]
L_8d176c:
	mov_s r2,0x882500
L_8d1772:
	bclr_s r0,r0,0x3
L_8d1774:
	st_s r0,[r1,0x2c]
L_8d1776:
	ld r0,[r1, 0xb0]
L_8d177a:
	bclr_s r0,r0,0x2
L_8d177c:
	st r0,[r1, 0xb0]
L_8d1780:
	mov_s r1,0x882000
L_8d1786:
	ld_s r0,[r1]
L_8d1788:
	bclr_s r0,r0,0x1c
L_8d178a:
	st_s r0,[r1]
L_8d178c:
	ld_s r0,[r2,0x54]
L_8d178e:
	bclr_s r0,r0,0x12
L_8d1790:
	st_s r0,[r2,0x54]
L_8d1792:
	ld_s r0,[r1,0x24]
L_8d1794:
	bclr_s r0,r0,0x1b
L_8d1796:
	st_s r0,[r1,0x24]
L_8d1798:
	ld_s r0,[r2,0x60]
L_8d179a:
	bclr_s r0,r0,0x3
L_8d179c:
	st_s r0,[r2,0x60]
L_8d179e:
	j_s [blink]
