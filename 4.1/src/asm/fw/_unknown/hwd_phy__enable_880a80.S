/* hwd_phy__enable_880a80 @ 0x8cee90, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_phy__power_up_seq, hwm__apply_mode_flags
 */
	.section .text.hwd_phy__enable_880a80,"ax",@progbits
	.global hwd_phy__enable_880a80
hwd_phy__enable_880a80:
	.global L_8cee90
L_8cee90:
	mov_s r3,0xfffc0000
L_8cee96:
	mov_s r2,0x880a80
L_8cee9c:
	mov_s r1,0x880c00
L_8ceea2:
	cmp_s r0,0x0
L_8ceea4:
	ld_s r0,[r2,0x74]
L_8ceea6:
	bmsk_s r0,r0,0x11
L_8ceea8:
	beq_s L_8ceebe
L_8ceeaa:
	or_s r0,r0,r3
L_8ceeac:
	st_s r0,[r2,0x74]
L_8ceeae:
	ld_s r0,[r2,0x78]
L_8ceeb0:
	or r0,r0,0x3f
L_8ceeb4:
	st_s r0,[r2,0x78]
L_8ceeb6:
	ld_s r0,[r1,0x28]
L_8ceeb8:
	or r0,r0,0xf
L_8ceebc:
	b_s L_8ceece
	.global L_8ceebe
L_8ceebe:
	st_s r0,[r2,0x74]
L_8ceec0:
	ld_s r0,[r2,0x78]
L_8ceec2:
	bic r0,r0,0x3f
L_8ceec6:
	st_s r0,[r2,0x78]
L_8ceec8:
	ld_s r0,[r1,0x28]
L_8ceeca:
	bic r0,r0,0xf
	.global L_8ceece
L_8ceece:
	st_s r0,[r1,0x28]
L_8ceed0:
	j_s [blink]
L_8ceed2:
	nop_s
