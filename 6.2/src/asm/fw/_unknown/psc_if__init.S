/* psc_if__init @ 0x8d9344, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   psc_if::init
 * Зовут его: PS_CONNECTION__assoc_ntf
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, obj_vt801eac__ctor, obj_vt801f08__ctor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global psc_if__init
psc_if__init:
	.global L_8d9344
L_8d9344:
	push_s blink
L_8d9346:
	bl L_8c01e0
L_8d934a:
	mov_s r13,r0
L_8d934c:
	mov_s r15,r1
L_8d934e:
	mov_s r14,r2
L_8d9350:
	mov_s r1,0x100272c
L_8d9356:
	bl.d L_8dcba8
L_8d935a:
	mov_s r0,0x2e
L_8d935c:
	st_s r15,[r13,0x48]
L_8d935e:
	st_s r14,[r13,0x44]
L_8d9360:
	ld_s r1,[r14,0x18]
L_8d9362:
	ld_s r1,[r1,0x50]
L_8d9364:
	mov_s r0,0x0
L_8d9366:
	cmp_s r1,0x2
L_8d9368:
	cmp.ne r1,0x3
L_8d936c:
	mov.eq r0,0x1
L_8d9370:
	extb.f r0,r0
L_8d9374:
	st_s r0,[r13,0x4c]
L_8d9376:
	beq_s L_8d9382
L_8d9378:
	mov_s r0,r13
L_8d937a:
	bl.d L_8d8b6c
L_8d937e:
	mov_s r1,r13
L_8d9380:
	b_s L_8d938c
	.global L_8d9382
L_8d9382:
	add r0,r13,0x20
L_8d9386:
	bl.d L_8d8c50
L_8d938a:
	mov_s r1,r13
	.global L_8d938c
L_8d938c:
	b L_8c024c
