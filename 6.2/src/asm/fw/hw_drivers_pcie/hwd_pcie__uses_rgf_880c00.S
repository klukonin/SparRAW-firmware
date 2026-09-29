/* hwd_pcie__uses_rgf_880c00 @ 0x8d173c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_program_all
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__uses_rgf_880c00
hwd_pcie__uses_rgf_880c00:
	.global L_8d173c
L_8d173c:
	mov_s r1,0x880c00
L_8d1742:
	ld_s r0,[r1,0x40]
L_8d1744:
	bclr_s r0,r0,0x0
L_8d1746:
	st_s r0,[r1,0x40]
L_8d1748:
	ld_s r0,[r1,0x54]
L_8d174a:
	bset_s r0,r0,0x1f
L_8d174c:
	st_s r0,[r1,0x54]
L_8d174e:
	ld_s r0,[r1,0x54]
L_8d1750:
	and r0,r0,0x8000ffff
L_8d1758:
	bset_s r0,r0,0x10
L_8d175a:
	st_s r0,[r1,0x54]
L_8d175c:
	ld_s r0,[r1,0x54]
L_8d175e:
	bmsk_s r0,r0,0x1e
L_8d1760:
	st_s r0,[r1,0x54]
L_8d1762:
	j_s [blink]
