/* regd__is_country_us @ 0x8da658, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__check_mode
 * Глобалы (через gp): 0x800214
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global regd__is_country_us
regd__is_country_us:
	.global L_8da658
L_8da658:
	ld_s r0,[gp,-0xc4]
L_8da65a:
	mov_s r1,0x0
L_8da65c:
	brne_s r0,0,L_8da668
L_8da65e:
	ldw_s r0,[gp,0x90]
L_8da660:
	breq r0,0x5553,L_8da66c
	.global L_8da668
L_8da668:
	mov_s r0,r1
L_8da66a:
	b_s L_8da66e
	.global L_8da66c
L_8da66c:
	mov_s r0,0x1
	.global L_8da66e
L_8da66e:
	j_s.d [blink]
L_8da670:
	extb_s r0,r0
L_8da672:
	nop_s
