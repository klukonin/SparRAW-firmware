/* set_g_8000b0_x3 @ 0x8ed0c0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__init_oob_pools
 * Глобалы (через gp): 0x800290
 */
	.section .text.set_g_8000b0_x3,"ax",@progbits
	.global set_g_8000b0_x3
set_g_8000b0_x3:
	.global L_8ed0c0
L_8ed0c0:
	mov_s r0,0x0
L_8ed0c2:
	st.as r0,[gp,0x48]
L_8ed0c6:
	st.as r0,[gp,-0x30]
L_8ed0ca:
	j_s.d [blink]
L_8ed0cc:
	st.as r0,[gp,-0x4]
