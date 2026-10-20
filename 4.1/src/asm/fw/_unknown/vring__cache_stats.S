/* vring__cache_stats @ 0x8d6a08, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__teardown
 * Глобалы (через gp): 0x8002c8, 0x8002cc, 0x8003b4
 */
	.section .text.vring__cache_stats,"ax",@progbits
	.global vring__cache_stats
vring__cache_stats:
	.global L_8d6a08
L_8d6a08:
	ld_s r0,[gp,0x244]
L_8d6a0a:
	ld_s r1,[r0,0x10]
L_8d6a0c:
	st.as r1,[gp,0x57]
L_8d6a10:
	ld r0,[r0, 0x88]
L_8d6a14:
	j_s.d [blink]
L_8d6a16:
	st.as r0,[gp,0x56]
L_8d6a1a:
	nop_s
