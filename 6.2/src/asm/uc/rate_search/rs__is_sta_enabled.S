/* rs__is_sta_enabled @ 0x9300ac, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rs_start, rx_funcs__rx_flow, sta__apply_bf_result
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rs__is_sta_enabled
rs__is_sta_enabled:
	.global L_9300ac
L_9300ac:
	mov_s r1,0x0
L_9300ae:
	bset r1,r1,r0
L_9300b2:
	ld_s r0,[gp,-0x8]
L_9300b4:
	and_s r0,r0,r1
L_9300b6:
	cmp_s r1,r0
L_9300b8:
	mov_s r0,0x1
L_9300ba:
	j_s.d [blink]
L_9300bc:
	sub_s.ne r0,r0,r0
L_9300be:
	nop_s
