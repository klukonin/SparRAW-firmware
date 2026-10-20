/* pcie__serdes_clear_flag_if_bit1 @ 0x8f3d6c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__serdes_clear_flag_if_bit1
pcie__serdes_clear_flag_if_bit1:
	.global L_8f3d6c
L_8f3d6c:
	mov_s r0,0x882580
L_8f3d72:
	ld_s r0,[r0,0x40]
L_8f3d74:
	bbit0 r0,0x1,L_8f3d7e
L_8f3d78:
	mov_s r0,0x0
L_8f3d7a:
	st.as r0,[gp,-0x3c]
	.global L_8f3d7e
L_8f3d7e:
	j_s [blink]
