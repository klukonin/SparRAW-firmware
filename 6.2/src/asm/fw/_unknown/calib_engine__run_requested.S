/* calib_engine__run_requested @ 0x8e4a28, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_mngr__restart_scheme
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, calib_engine__schedule_all_schemes, calib_mngr__engine_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__run_requested
calib_engine__run_requested:
	.global L_8e4a28
L_8e4a28:
	push_s blink
L_8e4a2a:
	bl L_8c01e0
L_8e4a2e:
	ld_s r13,[r0]
L_8e4a30:
	cmp_s r13,0x0
L_8e4a32:
	mov_s r13,0x1
L_8e4a34:
	sub_s.ne r13,r13,r13
L_8e4a36:
	mov_s r14,r0
L_8e4a38:
	brne r13,0x1,L_8e4a42
L_8e4a3c:
	bl L_8e91d4
L_8e4a40:
	b_s L_8e4a90
	.global L_8e4a42
L_8e4a42:
	mov_s r15,0x0
L_8e4a44:
	b_s L_8e4a8c
	.global L_8e4a46
L_8e4a46:
	mul64 r15,0x44
L_8e4a4a:
	add r0,mlo,0x804944
L_8e4a52:
	ldb_s r1,[r0]
L_8e4a54:
	cmp_s r1,0x0
L_8e4a56:
	mov_s r1,0x1
L_8e4a58:
	sub_s.ne r1,r1,r1
L_8e4a5a:
	extb.f 0x0,r1
L_8e4a5e:
	beq_s L_8e4a8a
L_8e4a60:
	asl_s r1,r15,0x2
L_8e4a62:
	add1_s r1,r1,r1
L_8e4a64:
	add_s r1,r1,r14
L_8e4a66:
	ld_s r3,[r1,0x4]
L_8e4a68:
	bbit0 r3,0x0,L_8e4a8a
L_8e4a6c:
	lsr_s r3,r3
L_8e4a6e:
	extb_s r3,r3
L_8e4a70:
	ldw r4,[r1, 0xe]
L_8e4a74:
	mov r5,0x5640
L_8e4a7c:
	ld_s r1,[r1,0x8]
L_8e4a7e:
	mov_s r2,r13
L_8e4a80:
	mov_s r6,r15
L_8e4a82:
	bl.d L_8e79c0
L_8e4a86:
	mov r7,0x0
	.global L_8e4a8a
L_8e4a8a:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8e4a8c
L_8e4a8c:
	brlo r15,0x6,L_8e4a46
	.global L_8e4a90
L_8e4a90:
	b L_8c024c
