/* mac__core_write_3d_0200 @ 0x92960c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__set_normal_mode
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__core_write_3d_0200
mac__core_write_3d_0200:
	.global L_92960c
L_92960c:
	mov_s r0,0x887000
L_929612:
	st.as 0x3d000200,[r0,-0x8e]
L_92961a:
	j_s [blink]
