/* rf__set_889494_low_nibble @ 0x8d46b8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__check_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__set_889494_low_nibble
rf__set_889494_low_nibble:
	.global L_8d46b8
L_8d46b8:
	mov_s r1,0x889480
L_8d46be:
	cmp_s r0,0x0
L_8d46c0:
	ld_s r0,[r1,0x14]
L_8d46c2:
	beq_s L_8d46d2
L_8d46c4:
	or r0,r0,0x3
L_8d46c8:
	st_s r0,[r1,0x14]
L_8d46ca:
	ld_s r0,[r1,0x14]
L_8d46cc:
	or r0,r0,0xc
L_8d46d0:
	b_s L_8d46de
	.global L_8d46d2
L_8d46d2:
	bic r0,r0,0x3
L_8d46d6:
	st_s r0,[r1,0x14]
L_8d46d8:
	ld_s r0,[r1,0x14]
L_8d46da:
	bic r0,r0,0xc
	.global L_8d46de
L_8d46de:
	st_s r0,[r1,0x14]
L_8d46e0:
	j_s [blink]
L_8d46e2:
	nop_s
