/* rfc__pack_field_value @ 0x8d32e4, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_obj__reset_results, hwf_calib_lo_power_flow
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__pack_field_value
rfc__pack_field_value:
	.global L_8d32e4
L_8d32e4:
	push_s blink
L_8d32e6:
	bl.d L_8c01e0
L_8d32ea:
	mov_s r6,r1
L_8d32ec:
	mov_s r0,r4
L_8d32ee:
	mov_s r1,r5
L_8d32f0:
	ld r14,[r6]
L_8d32f4:
	mov_s r15,0xfffff000
L_8d32fa:
	and_s r14,r14,r15
L_8d32fc:
	bmsk r13,r3,0x3
L_8d3300:
	or r5,r13,r14
L_8d3304:
	asl_s r14,r3,0x4
L_8d3306:
	mov_s r13,0xf0
L_8d3308:
	and r4,r14,r13
L_8d330c:
	mov_s r14,0xf
L_8d330e:
	asl_s r3,r3,0x8
L_8d3310:
	or r5,r5,r4
L_8d3314:
	asl_s r14,r14,0x8
L_8d3316:
	and r4,r3,r14
L_8d331a:
	or r3,r4,r5
L_8d331e:
	st_s r3,[r2]
L_8d3320:
	ld r3,[r6, 0x4]
L_8d3324:
	and_s r15,r15,r3
L_8d3326:
	bmsk r3,r0,0x3
L_8d332a:
	or_s r3,r3,r15
L_8d332c:
	asl_s r15,r0,0x4
L_8d332e:
	asl_s r0,r0,0x8
L_8d3330:
	and_s r15,r15,r13
L_8d3332:
	and_s r0,r0,r14
L_8d3334:
	or_s r3,r3,r15
L_8d3336:
	or_s r0,r0,r3
L_8d3338:
	st_s r0,[r2,0x4]
L_8d333a:
	ld r0,[r6, 0x8]
L_8d333e:
	bmsk r3,r1,0x3
L_8d3342:
	and r0,r0,0xffff0000
L_8d334a:
	or_s r3,r3,r0
L_8d334c:
	asl_s r0,r1,0x4
L_8d334e:
	and_s r13,r13,r0
L_8d3350:
	or_s r13,r13,r3
L_8d3352:
	asl r0,r1,0x8
L_8d3356:
	and_s r0,r0,r14
L_8d3358:
	or_s r0,r0,r13
L_8d335a:
	asl_s r1,r1,0xc
L_8d335c:
	and r1,r1,0xf000
L_8d3364:
	or_s r1,r1,r0
L_8d3366:
	b.d L_8c024c
L_8d336a:
	st_s r1,[r2,0x8]
