/* hwd_phy__uses_rgf_880c00_8d1d04 @ 0x8d1d04, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_phy__power_up_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__uses_rgf_880c00_8d1d04
hwd_phy__uses_rgf_880c00_8d1d04:
	.global L_8d1d04
L_8d1d04:
	mov_s r1,0x880c00
L_8d1d0a:
	cmp_s r0,0x0
L_8d1d0c:
	ld_s r0,[r1,0x78]
L_8d1d0e:
	beq_s L_8d1d20
L_8d1d10:
	bclr_s r0,r0,0x3
L_8d1d12:
	st_s r0,[r1,0x78]
L_8d1d14:
	ld_s r0,[r1,0x78]
L_8d1d16:
	bclr_s r0,r0,0x4
L_8d1d18:
	st_s r0,[r1,0x78]
L_8d1d1a:
	ld_s r0,[r1,0x78]
L_8d1d1c:
	bclr_s r0,r0,0x5
L_8d1d1e:
	b_s L_8d1d2e
	.global L_8d1d20
L_8d1d20:
	bset_s r0,r0,0x3
L_8d1d22:
	st_s r0,[r1,0x78]
L_8d1d24:
	ld_s r0,[r1,0x78]
L_8d1d26:
	bset_s r0,r0,0x4
L_8d1d28:
	st_s r0,[r1,0x78]
L_8d1d2a:
	ld_s r0,[r1,0x78]
L_8d1d2c:
	bset_s r0,r0,0x5
	.global L_8d1d2e
L_8d1d2e:
	st_s r0,[r1,0x78]
L_8d1d30:
	j_s [blink]
L_8d1d32:
	nop_s
