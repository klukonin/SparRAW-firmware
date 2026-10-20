/* get_g_8000ac_8c5824 @ 0x8c5824, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__validate_scan
 */
	.section .text.get_g_8000ac_8c5824,"ax",@progbits
	.global get_g_8000ac_8c5824
get_g_8000ac_8c5824:
	.global L_8c5824
L_8c5824:
	mov_s r1,0x0
L_8c5826:
	bset r1,r1,r0
L_8c582a:
	ld_s r0,[gp,-0xc4]
L_8c582c:
	and_s r0,r0,r1
L_8c582e:
	sub.f r0,r0,0x0
L_8c5832:
	j_s.d [blink]
L_8c5834:
	mov.ne r0,0x1
