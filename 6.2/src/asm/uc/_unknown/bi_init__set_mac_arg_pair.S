/* bi_init__set_mac_arg_pair @ 0x934e0c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_init__set_mac_arg_pair
bi_init__set_mac_arg_pair:
	.global L_934e0c
L_934e0c:
	mov_s r2,0x886d00
L_934e12:
	st_s r1,[r2,0x24]
L_934e14:
	st_s r0,[r2,0x20]
L_934e16:
	j_s [blink]
