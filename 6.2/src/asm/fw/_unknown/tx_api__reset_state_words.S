/* tx_api__reset_state_words @ 0x8f5270, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_api__init_pools
 * Глобалы (через gp): 0x8002a4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__reset_state_words
tx_api__reset_state_words:
	.global L_8f5270
L_8f5270:
	mov_s r0,0x0
L_8f5272:
	st.as r0,[gp,0x48]
L_8f5276:
	st.as r0,[gp,-0x34]
L_8f527a:
	j_s.d [blink]
L_8f527c:
	st.as r0,[gp,-0x7]
