/* radio_mgr__alloc_request @ 0x8de3d4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   radio_manager.cpp
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, mem_pool__free, radio_mgr__unlink_request
 */
	.section .text.radio_mgr__alloc_request,"ax",@progbits
	.global radio_mgr__alloc_request
radio_mgr__alloc_request:
L_8de3d4:
	stb_s r2,[r0]
	.global sub_8de3d6
sub_8de3d6:
L_8de3d6:
	nop_s
L_8de3d8:
	push_s blink
L_8de3da:
	bl L_8c02c4
L_8de3de:
	mov.f r14,r1
L_8de3e2:
	mov_s r13,r0
L_8de3e4:
	beq_s L_8de400
	.global L_8de3e6
L_8de3e6:
	add r0,r13,0x18
L_8de3ea:
	bl.d L_8de424
L_8de3ee:
	mov_s r1,r14
L_8de3f0:
	breq_s r0,0,L_8de416
L_8de3f2:
	mov_s r0,0x0
L_8de3f4:
	st_s r0,[r14,0x8]
L_8de3f6:
	add_s r0,r13,0x4
L_8de3f8:
	bl.d L_8c9268
L_8de3fc:
	mov_s r1,r14
L_8de3fe:
	b_s L_8de420
	.global L_8de400
L_8de400:
	mov_s r0,blink
L_8de402:
	mov_s r2,0x1015cc4
L_8de408:
	mov_s r1,0x115f
L_8de40e:
	bl.d L_8c82c0
L_8de412:
	mov_s r3,0x36
L_8de414:
	b_s L_8de3e6
	.global L_8de416
L_8de416:
	ld_s r0,[r13]
L_8de418:
	ld_s r2,[r0,0x10]
L_8de41a:
	mov_s r0,r13
L_8de41c:
	jl_s.d [r2]
L_8de41e:
	mov_s r1,r14
	.global L_8de420
L_8de420:
	b L_8c0334
