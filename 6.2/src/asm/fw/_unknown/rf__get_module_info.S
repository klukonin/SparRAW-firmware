/* rf__get_module_info @ 0x8f3704, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_get_rf_status
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, memset_fw, rfca__get_rf_set_lo8
 * Глобалы (через gp): 0x800243
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__get_module_info
rf__get_module_info:
	.global L_8f3704
L_8f3704:
	push_s blink
L_8f3706:
	bl L_8c01dc
L_8f370a:
	sub_s sp,sp,0x4
L_8f370c:
	mov_s r16,r0
L_8f370e:
	mov_s r14,r4
L_8f3710:
	mov_s r13,r5
L_8f3712:
	mov_s r15,r6
L_8f3714:
	breq_s r1,0,L_8f3720
L_8f3716:
	mov_s r0,0x880a7c
L_8f371c:
	ldw_s r0,[r0,0x12]
L_8f371e:
	st_s r0,[r1]
	.global L_8f3720
L_8f3720:
	breq_s r2,0,L_8f3726
L_8f3722:
	ldb_s r0,[gp,0xbf]
L_8f3724:
	st_s r0,[r2]
	.global L_8f3726
L_8f3726:
	breq_s r3,0,L_8f3732
L_8f3728:
	ldb r0,[r16,0x45e]
L_8f3730:
	st_s r0,[r3]
	.global L_8f3732
L_8f3732:
	breq_s r14,0,L_8f373a
L_8f3734:
	bl L_8ce82c
L_8f3738:
	st_s r0,[r14]
	.global L_8f373a
L_8f373a:
	breq_s r13,0,L_8f376a
L_8f373c:
	mov_s r0,r13
L_8f373e:
	mov_s r1,0x1
L_8f3740:
	bl.d L_8ddf84
L_8f3744:
	mov_s r2,r15
L_8f3746:
	ldb r1,[r16,0x45e]
L_8f374e:
	mov_s r14,sp
L_8f3750:
	bl.d L_8e5dfc
L_8f3754:
	mov_s r0,r14
L_8f3756:
	b_s L_8f3762
	.global L_8f3758
L_8f3758:
	bl.d L_8df444
L_8f375c:
	mov_s r0,r14
L_8f375e:
	brlo r0,r15,L_8f3770
	.global L_8f3762
L_8f3762:
	bl.d L_8cdcc4
L_8f3766:
	mov_s r0,r14
L_8f3768:
	brne_s r0,0,L_8f3758
	.global L_8f376a
L_8f376a:
	b.d L_8c0244
L_8f376e:
	add_s sp,sp,0x4
	.global L_8f3770
L_8f3770:
	mov_s r1,0x880a3c
L_8f3776:
	ld_s r1,[r1,0x2c]
L_8f3778:
	add_s r0,r0,r13
L_8f377a:
	stb_s r1,[r0]
L_8f377c:
	b_s L_8f3762
L_8f377e:
	nop_s
