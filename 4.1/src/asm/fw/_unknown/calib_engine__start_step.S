/* calib_engine__start_step @ 0x8dfd78, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_mngr__restart_scheme
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, calib_engine__post_event, calib_engine__schedule_all_schemes
 */
	.section .text.calib_engine__start_step,"ax",@progbits
	.global calib_engine__start_step
calib_engine__start_step:
	.global L_8dfd78
L_8dfd78:
	push_s blink
L_8dfd7a:
	bl L_8c02c0
L_8dfd7e:
	ld_s r13,[r0]
L_8dfd80:
	cmp_s r13,0x0
L_8dfd82:
	mov_s r13,0x1
L_8dfd84:
	sub_s.ne r13,r13,r13
L_8dfd86:
	mov_s r14,r0
L_8dfd88:
	brne r13,0x1,L_8dfd92
L_8dfd8c:
	bl L_8e4334
L_8dfd90:
	b_s L_8dfdd2
	.global L_8dfd92
L_8dfd92:
	mov_s r15,0x0
L_8dfd94:
	b_s L_8dfdce
	.global L_8dfd96
L_8dfd96:
	asl_s r1,r15,0x2
L_8dfd98:
	add1_s r1,r1,r1
L_8dfd9a:
	add_s r1,r1,r14
L_8dfd9c:
	ld_s r3,[r1,0x4]
L_8dfd9e:
	bbit0 r3,0x0,L_8dfdcc
L_8dfda2:
	asl_s r2,r15,0x5
L_8dfda4:
	add1_s r2,r2,r2
L_8dfda6:
	add r0,r2,0x842860
L_8dfdae:
	lsr_s r3,r3
L_8dfdb0:
	extb_s r3,r3
L_8dfdb2:
	ldw r4,[r1, 0xe]
L_8dfdb6:
	mov r5,0x4aec
L_8dfdbe:
	ld_s r1,[r1,0x8]
L_8dfdc0:
	mov_s r2,r13
L_8dfdc2:
	mov_s r6,r15
L_8dfdc4:
	bl.d L_8e27a4
L_8dfdc8:
	mov r7,0x0
	.global L_8dfdcc
L_8dfdcc:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8dfdce
L_8dfdce:
	brlo r15,0x6,L_8dfd96
	.global L_8dfdd2
L_8dfdd2:
	b L_8c032c
L_8dfdd6:
	nop_s
