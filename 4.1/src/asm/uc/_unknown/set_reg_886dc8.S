/* set_reg_886dc8 @ 0x926e64, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_substep
 */
	.section .text.set_reg_886dc8,"ax",@progbits
	.global set_reg_886dc8
set_reg_886dc8:
	.global L_926e64
L_926e64:
	mov_s r0,0x887000
L_926e6a:
	st.as 0x3e000000,[r0,-0x8e]
L_926e72:
	st.as 0x3d000007,[r0,-0x8e]
L_926e7a:
	j_s [blink]
