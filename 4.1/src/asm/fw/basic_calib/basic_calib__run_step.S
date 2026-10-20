/* basic_calib__run_step @ 0x8c66a4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_calib.cpp
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_engine__step, hwf_calib_all
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.basic_calib__run_step,"ax",@progbits
	.global basic_calib__run_step
basic_calib__run_step:
	.global L_8c66a4
L_8c66a4:
	sub_s sp,sp,0x4
L_8c66a6:
	push_s blink
L_8c66a8:
	bl L_8c02b8
L_8c66ac:
	mov_s r16,r1
L_8c66ae:
	mov.f r14,r3
L_8c66b2:
	mov_s r13,r0
L_8c66b4:
	mov_s r17,r2
L_8c66b6:
	beq_s L_8c66e4
	.global L_8c66b8
L_8c66b8:
	ld_s r0,[r13,0x8]
L_8c66ba:
	ld_s r2,[r0,0x18]
L_8c66bc:
	mov_s r0,r13
L_8c66be:
	jl_s.d [r2]
L_8c66c0:
	mov_s r1,r16
L_8c66c2:
	ld_s r0,[r13,0x8]
L_8c66c4:
	mov_s r1,r16
L_8c66c6:
	ld_s r15,[r0,0x1c]
L_8c66c8:
	mov_s r0,r13
L_8c66ca:
	mov_s r2,r17
L_8c66cc:
	jl_s.d [r15]
L_8c66ce:
	mov_s r3,r14
L_8c66d0:
	mov_s r17,r0
L_8c66d2:
	ld_s r0,[r13,0x8]
L_8c66d4:
	ld_s r2,[r0,0x20]
L_8c66d6:
	mov_s r0,r13
L_8c66d8:
	jl_s.d [r2]
L_8c66da:
	mov_s r1,r16
L_8c66dc:
	mov_s r0,r17
L_8c66de:
	mov_s r12,0x8
L_8c66e0:
	b L_8c031e
	.global L_8c66e4
L_8c66e4:
	mov_s r0,blink
L_8c66e6:
	mov_s r2,0x1008ac4
L_8c66ec:
	mov_s r1,0x81
L_8c66ee:
	bset_s r1,r1,0xc
L_8c66f0:
	bl.d L_8c82c0
L_8c66f4:
	mov_s r3,0x21
L_8c66f6:
	b_s L_8c66b8
