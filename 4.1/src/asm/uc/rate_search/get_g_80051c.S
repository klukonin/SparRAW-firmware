/* get_g_80051c @ 0x92c30c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__start_request, rate_search__start_for_sta, rx_funcs__rx_flow
 */
	.section .text.get_g_80051c,"ax",@progbits
	.global get_g_80051c
get_g_80051c:
	.global L_92c30c
L_92c30c:
	mov_s r1,0x0
L_92c30e:
	bset r1,r1,r0
L_92c312:
	ld_s r0,[gp,-0xc]
L_92c314:
	and_s r0,r0,r1
L_92c316:
	cmp_s r1,r0
L_92c318:
	mov_s r0,0x1
L_92c31a:
	j_s.d [blink]
L_92c31c:
	sub_s.ne r0,r0,r0
L_92c31e:
	nop_s
