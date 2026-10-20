/* regd__is_unset_or_jp @ 0x8da3bc, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__check_mode
 * Глобалы (через gp): 0x800214
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global regd__is_unset_or_jp
regd__is_unset_or_jp:
	.global L_8da3bc
L_8da3bc:
	ld_s r0,[gp,-0xc4]
L_8da3be:
	mov_s r1,0x0
L_8da3c0:
	breq_s r0,0,L_8da3d0
L_8da3c2:
	ldw_s r0,[gp,0x90]
L_8da3c4:
	cmp_s r0,0x4a50
L_8da3ca:
	mov.ne r0,r1
L_8da3ce:
	bne_s L_8da3d2
	.global L_8da3d0
L_8da3d0:
	mov_s r0,0x1
	.global L_8da3d2
L_8da3d2:
	j_s.d [blink]
L_8da3d4:
	extb_s r0,r0
L_8da3d6:
	nop_s
