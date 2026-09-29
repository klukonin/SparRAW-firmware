/* hwd_pcie__rgf_880c00 @ 0x8cea54, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_program_all
 */
	.section .text.hwd_pcie__rgf_880c00,"ax",@progbits
	.global hwd_pcie__rgf_880c00
hwd_pcie__rgf_880c00:
	.global L_8cea54
L_8cea54:
	mov_s r1,0x880c00
L_8cea5a:
	ld_s r0,[r1,0x40]
L_8cea5c:
	bclr_s r0,r0,0x0
L_8cea5e:
	st_s r0,[r1,0x40]
L_8cea60:
	ld_s r0,[r1,0x54]
L_8cea62:
	bset_s r0,r0,0x1f
L_8cea64:
	st_s r0,[r1,0x54]
L_8cea66:
	ld_s r0,[r1,0x54]
L_8cea68:
	and r0,r0,0x8000ffff
L_8cea70:
	bset_s r0,r0,0x10
L_8cea72:
	st_s r0,[r1,0x54]
L_8cea74:
	ld_s r0,[r1,0x54]
L_8cea76:
	bmsk_s r0,r0,0x1e
L_8cea78:
	st_s r0,[r1,0x54]
L_8cea7a:
	j_s [blink]
