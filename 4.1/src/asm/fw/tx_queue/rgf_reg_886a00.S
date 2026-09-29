/* rgf_reg_886a00 @ 0x8e50c4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 */
	.section .text.rgf_reg_886a00,"ax",@progbits
	.global rgf_reg_886a00
rgf_reg_886a00:
	.global L_8e50c4
L_8e50c4:
	push_s blink
L_8e50c6:
	mov_s r1,0x886a00
L_8e50cc:
	ld_s r0,[r1,0x28]
L_8e50ce:
	or r0,r0,0x3
L_8e50d2:
	st_s r0,[r1,0x28]
L_8e50d4:
	sync
L_8e50d8:
	mov_s r1,0x886a00
L_8e50de:
	ld_s r0,[r1,0x28]
L_8e50e0:
	bic r0,r0,0x3
L_8e50e4:
	st_s r0,[r1,0x28]
L_8e50e6:
	sync
L_8e50ea:
	pop_s blink
L_8e50ec:
	j_s [blink]
L_8e50ee:
	nop_s
