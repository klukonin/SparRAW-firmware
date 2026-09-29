/* basic_calib__check_g8000a4 @ 0x8cb91c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: basic_calib_sparrow__estimation_alg, link_lost_diag_part2, wmi__cmd_arg_check
 * Зовёт сам: fw_divmod_signed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global basic_calib__check_g8000a4
basic_calib__check_g8000a4:
	.global L_8cb91c
L_8cb91c:
	push_s blink
L_8cb91e:
	ld.as r1,[gp,-0x38]
L_8cb922:
	brne r0,0x1,L_8cb938
L_8cb926:
	cmp r1,-0x1
L_8cb92a:
	beq_s L_8cb938
L_8cb92c:
	mov_s r0,r1
L_8cb92e:
	bl.d L_8c02dc
L_8cb932:
	mov r1,0x3e8
L_8cb936:
	b_s L_8cb93a
	.global L_8cb938
L_8cb938:
	mov_s r0,r1
	.global L_8cb93a
L_8cb93a:
	pop_s blink
L_8cb93c:
	j_s [blink]
L_8cb93e:
	nop_s
