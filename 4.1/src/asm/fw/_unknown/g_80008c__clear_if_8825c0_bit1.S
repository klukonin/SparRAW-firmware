/* g_80008c__clear_if_8825c0_bit1 @ 0x8ec05c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_init
 */
	.section .text.g_80008c__clear_if_8825c0_bit1,"ax",@progbits
	.global g_80008c__clear_if_8825c0_bit1
g_80008c__clear_if_8825c0_bit1:
	.global L_8ec05c
L_8ec05c:
	mov_s r0,0x882580
L_8ec062:
	ld_s r0,[r0,0x40]
L_8ec064:
	bbit0 r0,0x1,L_8ec06e
L_8ec068:
	mov_s r0,0x0
L_8ec06a:
	st.as r0,[gp,-0x39]
	.global L_8ec06e
L_8ec06e:
	j_s [blink]
