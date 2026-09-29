/* mac__core_write_3e_then_3d_0007 @ 0x9295f4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__set_normal_mode
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__core_write_3e_then_3d_0007
mac__core_write_3e_then_3d_0007:
	.global L_9295f4
L_9295f4:
	mov_s r0,0x887000
L_9295fa:
	st.as 0x3e000000,[r0,-0x8e]
L_929602:
	st.as 0x3d000007,[r0,-0x8e]
L_92960a:
	j_s [blink]
