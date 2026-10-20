/* get_g_800674 @ 0x928e5c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: get_tx_eligibility
 */
	.section .text.get_g_800674,"ax",@progbits
	.global get_g_800674
get_g_800674:
	.global L_928e5c
L_928e5c:
	mov_s r0,0x800674
L_928e62:
	j_s.d [blink]
L_928e64:
	ld_s r0,[r0]
L_928e66:
	nop_s
