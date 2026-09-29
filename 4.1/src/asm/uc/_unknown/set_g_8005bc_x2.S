/* set_g_8005bc_x2 @ 0x92b9b8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x00_handler
 * Глобалы (через gp): 0x8005bc, 0x8005c0
 */
	.section .text.set_g_8005bc_x2,"ax",@progbits
	.global set_g_8005bc_x2
set_g_8005bc_x2:
	.global L_92b9b8
L_92b9b8:
	mov_s r0,0x10d6c
L_92b9be:
	st.as r0,[gp,0x26]
L_92b9c2:
	mov_s r0,0x10d2c
L_92b9c8:
	j_s.d [blink]
L_92b9ca:
	st.as r0,[gp,0x25]
L_92b9ce:
	nop_s
