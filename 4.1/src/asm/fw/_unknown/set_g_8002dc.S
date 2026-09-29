/* set_g_8002dc @ 0x8c1820, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: memset0_words
 * Глобалы (через gp): 0x8002dc
 */
	.section .text.set_g_8002dc,"ax",@progbits
	.global set_g_8002dc
set_g_8002dc:
L_8c1820:
	mov_s r0,0x800580
L_8c1826:
	b L_8c1b08
L_8c182a:
	nop_s
L_8c182c:
	mov_s r0,0x800694
L_8c1832:
	j_s.d [blink]
L_8c1834:
	st.as r0,[gp,0x5b]
