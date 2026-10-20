/* class_calib_lo_power__check_online_estimation_condition @ 0x8c86dc, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   class_calib_lo_power::check_online_estimation_condition: LO_POWER_CONFIG_LOW_XIF_LEAK [bb:%d rf:%d]
 *   class_calib_lo_power::check_online_estimation_condition: LO_POWER_CONFIG_HI_EMISSION [bb:%d rf:%d]
 *   class_calib_lo_power::check_online_estimation_condition: state changed, perform correction [bb:%d rf:%d]
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, class_calib_lo_power__change_state_by_temperature, fw_log__emit2
 */
	.section .text.class_calib_lo_power__check_online_estimation_condition,"ax",@progbits
	.global class_calib_lo_power__check_online_estimation_condition
class_calib_lo_power__check_online_estimation_condition:
L_8c86dc:
	sub_s sp,sp,0x4
L_8c86de:
	push_s blink
L_8c86e0:
	bl.d L_8c02c4
L_8c86e4:
	add_s r2,r0,0x4
L_8c86e6:
	mov_s r14,r0
L_8c86e8:
	ld_s r0,[r0,0x8]
L_8c86ea:
	ld_s r3,[r0,0x2c]
L_8c86ec:
	mov_s r0,r14
L_8c86ee:
	jl_s.d [r3]
L_8c86f0:
	mov_s r1,r14
L_8c86f2:
	ld_s r1,[r14]
L_8c86f4:
	mov r0,-0x1
L_8c86f8:
	breq r1,r0,L_8c8702
L_8c86fc:
	ld_s r1,[r14,0x4]
L_8c86fe:
	brne r1,r0,L_8c8706
	.global L_8c8702
L_8c8702:
	mov_s r0,0x1
L_8c8704:
	b_s L_8c879a
	.global L_8c8706
L_8c8706:
	mov_s r3,0x800f3c
L_8c870c:
	ld r4,[r3, 0x4]
L_8c8710:
	mov_s r0,r14
L_8c8712:
	ld r5,[r3, 0x8]
L_8c8716:
	mov_s r13,0x0
L_8c8718:
	ld r6,[r3, 0xc]
L_8c871c:
	ld_s r2,[r14,0x10]
L_8c871e:
	bl.d L_8c4e68
L_8c8722:
	ld_s r3,[r3]
L_8c8724:
	st_s r0,[r14,0x10]
L_8c8726:
	mov_s r3,0x800f2c
L_8c872c:
	ld r4,[r3, 0x4]
L_8c8730:
	mov_s r0,r14
L_8c8732:
	ld r5,[r3, 0x8]
L_8c8736:
	ld r6,[r3, 0xc]
L_8c873a:
	ld_s r1,[r14]
L_8c873c:
	ld_s r2,[r14,0x14]
L_8c873e:
	bl.d L_8c4e68
L_8c8742:
	ld_s r3,[r3]
L_8c8744:
	st_s r0,[r14,0x14]
L_8c8746:
	ld_s r1,[r14,0x10]
L_8c8748:
	ld_s r3,[r14]
L_8c874a:
	cmp_s r1,0x0
L_8c874c:
	ld r4,[r14, 0x4]
L_8c8750:
	cmp.eq r0,0x0
L_8c8754:
	bne_s L_8c875e
L_8c8756:
	mov_s r2,0x1008d50
L_8c875c:
	b_s L_8c8766
	.global L_8c875e
L_8c875e:
	mov_s r13,0x1
L_8c8760:
	mov_s r2,0x1008db4
	.global L_8c8766
L_8c8766:
	mov_s r0,0x6
L_8c8768:
	bl.d L_8edff8
L_8c876c:
	mov_s r1,0x2
L_8c876e:
	ld_s r0,[r14,0xc]
L_8c8770:
	cmp_s r13,r0
L_8c8772:
	mov.eq r13,0x0
L_8c8776:
	beq_s L_8c8790
L_8c8778:
	st_s r13,[r14,0xc]
L_8c877a:
	mov_s r13,0x1
L_8c877c:
	mov_s r2,0x1008e18
L_8c8782:
	ld r4,[r14, 0x4]
L_8c8786:
	mov_s r0,0x6
L_8c8788:
	mov_s r1,0x2
L_8c878a:
	bl.d L_8edff8
L_8c878e:
	ld_s r3,[r14]
	.global L_8c8790
L_8c8790:
	cmp_s r13,0x1
L_8c8792:
	mov_s r1,0x1
L_8c8794:
	sub_s.ne r1,r1,r1
L_8c8796:
	mov_s r0,0x1
L_8c8798:
	add1_s r0,r0,r1
	.global L_8c879a
L_8c879a:
	mov_s r12,0x8
L_8c879c:
	b L_8c0336
