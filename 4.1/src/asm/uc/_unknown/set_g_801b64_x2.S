/* set_g_801b64_x2 @ 0x935ec4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 */
	.section .text.set_g_801b64_x2,"ax",@progbits
	.global set_g_801b64_x2
set_g_801b64_x2:
	.global L_935ec4
L_935ec4:
	mov_s r0,0x1f
L_935ec6:
	mov_s r1,0x801b60
L_935ecc:
	st_s r0,[r1,0x4]
L_935ece:
	mov_s r0,0x11
L_935ed0:
	j_s.d [blink]
L_935ed2:
	st_s r0,[r1,0xc]
