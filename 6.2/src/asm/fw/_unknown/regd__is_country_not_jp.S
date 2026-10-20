/* regd__is_country_not_jp @ 0x8da3d8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__check_mode
 * Глобалы (через gp): 0x800214
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global regd__is_country_not_jp
regd__is_country_not_jp:
	.global L_8da3d8
L_8da3d8:
	ld_s r0,[gp,-0xc4]
L_8da3da:
	mov_s r1,0x0
L_8da3dc:
	brne_s r0,0,L_8da3e8
L_8da3de:
	ldw_s r0,[gp,0x90]
L_8da3e0:
	brne r0,0x4a50,L_8da3ec
	.global L_8da3e8
L_8da3e8:
	mov_s r0,r1
L_8da3ea:
	b_s L_8da3ee
	.global L_8da3ec
L_8da3ec:
	mov_s r0,0x1
	.global L_8da3ee
L_8da3ee:
	j_s.d [blink]
L_8da3f0:
	extb_s r0,r0
L_8da3f2:
	nop_s
