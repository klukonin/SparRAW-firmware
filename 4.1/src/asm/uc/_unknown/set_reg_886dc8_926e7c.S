/* set_reg_886dc8_926e7c @ 0x926e7c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_substep
 */
	.section .text.set_reg_886dc8_926e7c,"ax",@progbits
	.global set_reg_886dc8_926e7c
set_reg_886dc8_926e7c:
	.global L_926e7c
L_926e7c:
	mov_s r0,0x887000
L_926e82:
	st.as 0x3d000200,[r0,-0x8e]
L_926e8a:
	j_s [blink]
