/* hwd_phy__enable_880a80 @ 0x8d1b2c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_phy__power_up_seq, hwm__apply_mode_flags
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__enable_880a80
hwd_phy__enable_880a80:
	.global L_8d1b2c
L_8d1b2c:
	mov_s r3,0xfffc0000
L_8d1b32:
	mov_s r2,0x880a80
L_8d1b38:
	mov_s r1,0x880c00
L_8d1b3e:
	cmp_s r0,0x0
L_8d1b40:
	ld_s r0,[r2,0x74]
L_8d1b42:
	bmsk_s r0,r0,0x11
L_8d1b44:
	beq_s L_8d1b5a
L_8d1b46:
	or_s r0,r0,r3
L_8d1b48:
	st_s r0,[r2,0x74]
L_8d1b4a:
	ld_s r0,[r2,0x78]
L_8d1b4c:
	or r0,r0,0x3f
L_8d1b50:
	st_s r0,[r2,0x78]
L_8d1b52:
	ld_s r0,[r1,0x28]
L_8d1b54:
	or r0,r0,0xf
L_8d1b58:
	b_s L_8d1b6a
	.global L_8d1b5a
L_8d1b5a:
	st_s r0,[r2,0x74]
L_8d1b5c:
	ld_s r0,[r2,0x78]
L_8d1b5e:
	bic r0,r0,0x3f
L_8d1b62:
	st_s r0,[r2,0x78]
L_8d1b64:
	ld_s r0,[r1,0x28]
L_8d1b66:
	bic r0,r0,0xf
	.global L_8d1b6a
L_8d1b6a:
	st_s r0,[r1,0x28]
L_8d1b6c:
	j_s [blink]
L_8d1b6e:
	nop_s
