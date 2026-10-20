/* remove_app_ie @ 0x8e2600, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   remove_app_ie: frame type %x length %d. IE type: %d
 * Зовут его: schedule_scheme_builder__build_allocations_8c68a0
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, app_ie__remove_tlv, fw_log_emit2, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global remove_app_ie
remove_app_ie:
	.global L_8e2600
L_8e2600:
	b.d L_8e2608
L_8e2604:
	add_s r0,r0,0x48
L_8e2606:
	nop_s
	.global L_8e2608
L_8e2608:
	push_s blink
L_8e260a:
	bl L_8c01d8
L_8e260e:
	mov_s r16,r0
L_8e2610:
	mov_s r13,r1
L_8e2612:
	mov_s r17,r2
L_8e2614:
	mov_s r1,0x100c8d0
L_8e261a:
	mov_s r0,0x2b
L_8e261c:
	mov_s r2,r13
L_8e261e:
	bl.d L_8dcc80
L_8e2622:
	mov_s r3,r17
L_8e2624:
	brhs.d r13,0x5,L_8e265c
L_8e2628:
	mov_s r14,0x0
L_8e262a:
	ldb.x r13,[0x8023c0,r13]
L_8e2632:
	add r0,pcl,0xa
L_8e2636:
	add1_s r0,r0,r13
L_8e2638:
	j_s [r0]
L_8e263a:
	add3 r0,r16,0x3c
L_8e263e:
	b_s L_8e266a
L_8e2640:
	add3 r0,r16,0x36
L_8e2644:
	b_s L_8e266a
L_8e2646:
	mov_s r0,r16
L_8e2648:
	add r0,r0,0x1bc
L_8e264c:
	b_s L_8e266a
L_8e264e:
	add3 r0,r16,0x39
L_8e2652:
	b_s L_8e266a
L_8e2654:
	mov_s r0,r16
L_8e2656:
	add r0,r0,0x1d4
L_8e265a:
	b_s L_8e266a
	.global L_8e265c
L_8e265c:
	mov_s r0,blink
L_8e265e:
	mov_s r1,0x1370
L_8e2664:
	bl L_8c9b28
L_8e2668:
	mov_s r0,r14
	.global L_8e266a
L_8e266a:
	bl.d L_8e255c
L_8e266e:
	mov_s r1,r17
L_8e2670:
	b L_8c023c
