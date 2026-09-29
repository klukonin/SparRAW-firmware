/* hwd_phy__enable_880b00 @ 0x8cf484, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_phy__power_up_seq
 */
	.section .text.hwd_phy__enable_880b00,"ax",@progbits
	.global hwd_phy__enable_880b00
hwd_phy__enable_880b00:
	.global L_8cf484
L_8cf484:
	mov_s r3,0xfffc0000
L_8cf48a:
	mov_s r2,0x880b00
L_8cf490:
	mov_s r1,0x880c00
L_8cf496:
	cmp_s r0,0x0
L_8cf498:
	ld_s r0,[r2,0x8]
L_8cf49a:
	beq_s L_8cf4b2
L_8cf49c:
	or r0,r0,0x3f
L_8cf4a0:
	st_s r0,[r2,0x8]
L_8cf4a2:
	ld_s r0,[r2,0x4]
L_8cf4a4:
	bmsk_s r0,r0,0x11
L_8cf4a6:
	or_s r0,r0,r3
L_8cf4a8:
	st_s r0,[r2,0x4]
L_8cf4aa:
	ld_s r0,[r1,0x2c]
L_8cf4ac:
	or r0,r0,0xf
L_8cf4b0:
	b_s L_8cf4c4
	.global L_8cf4b2
L_8cf4b2:
	bic r0,r0,0x3f
L_8cf4b6:
	st_s r0,[r2,0x8]
L_8cf4b8:
	ld_s r0,[r2,0x4]
L_8cf4ba:
	bmsk_s r0,r0,0x11
L_8cf4bc:
	st_s r0,[r2,0x4]
L_8cf4be:
	ld_s r0,[r1,0x2c]
L_8cf4c0:
	bic r0,r0,0xf
	.global L_8cf4c4
L_8cf4c4:
	st_s r0,[r1,0x2c]
L_8cf4c6:
	j_s [blink]
