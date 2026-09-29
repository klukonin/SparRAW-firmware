/* set_g_80067c @ 0x928ca8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: get_tx_eligibility, internal_tx__pending_sm
 */
	.section .text.set_g_80067c,"ax",@progbits
	.global set_g_80067c
set_g_80067c:
	.global L_928ca8
L_928ca8:
	mov_s r1,0x0
L_928caa:
	mov_s r0,0x800674
L_928cb0:
	j_s.d [blink]
L_928cb2:
	st_s r1,[r0,0x8]
