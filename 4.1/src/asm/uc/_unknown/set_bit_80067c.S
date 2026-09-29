/* set_bit_80067c @ 0x928c98, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: get_tx_eligibility
 */
	.section .text.set_bit_80067c,"ax",@progbits
	.global set_bit_80067c
set_bit_80067c:
	.global L_928c98
L_928c98:
	mov_s r2,0x800674
L_928c9e:
	ld_s r1,[r2,0x8]
L_928ca0:
	bset r1,r1,r0
L_928ca4:
	j_s.d [blink]
L_928ca6:
	st_s r1,[r2,0x8]
