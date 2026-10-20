/* ber_test__accumulate_counters @ 0x8ed83c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, ber_test__measure
 */
	.section .text.ber_test__accumulate_counters,"ax",@progbits
	.global ber_test__accumulate_counters
ber_test__accumulate_counters:
	.global L_8ed83c
L_8ed83c:
	push_s r13
L_8ed83e:
	push_s r14
L_8ed840:
	ld_s r1,[r0,0x34]
L_8ed842:
	cmp_s r1,0x1
L_8ed844:
	mov.eq r0,0x0
L_8ed848:
	beq_s L_8ed874
L_8ed84a:
	ld_s r2,[r0,0x28]
L_8ed84c:
	ld_s r1,[r0,0x2c]
L_8ed84e:
	ld_s r13,[r0,0x1c]
L_8ed850:
	add_s r1,r1,r2
L_8ed852:
	st_s r1,[r0,0x2c]
L_8ed854:
	brne r1,r13,L_8ed864
L_8ed858:
	ld_s r14,[r0,0x30]
L_8ed85a:
	ld_s r3,[r0,0x24]
L_8ed85c:
	brne r14,r3,L_8ed864
L_8ed860:
	mov_s r3,0x1
L_8ed862:
	st_s r3,[r0,0x34]
	.global L_8ed864
L_8ed864:
	brge r13,r1,L_8ed872
L_8ed868:
	ld_s r1,[r0,0x18]
L_8ed86a:
	st_s r1,[r0,0x2c]
L_8ed86c:
	ld_s r1,[r0,0x30]
L_8ed86e:
	add_s r1,r1,r2
L_8ed870:
	st_s r1,[r0,0x30]
	.global L_8ed872
L_8ed872:
	mov_s r0,0x1
	.global L_8ed874
L_8ed874:
	pop_s r14
L_8ed876:
	j_s.d [blink]
L_8ed878:
	pop_s r13
L_8ed87a:
	nop_s
