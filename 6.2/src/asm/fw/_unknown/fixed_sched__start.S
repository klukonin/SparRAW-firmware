/* fixed_sched__start @ 0x8c9884, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_enable_fixed_scheduling, wmi_fixed_sched__apply
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, add_bcon, fixed_sched__get_entry_count, ie__scan_buf_10, lmac_cmd_pool__alloc, lmac_if__post_cmd, mem_pool__alloc_locked, mid__state_is_2_or_3, mid_list__by_mid_fw, sched__init_default_alloc_table, vring_tbl__entry_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fixed_sched__start
fixed_sched__start:
	.global L_8c9884
L_8c9884:
	push_s blink
L_8c9886:
	bl L_8c01e0
L_8c988a:
	sub_s sp,sp,0x4
L_8c988c:
	mov_s r15,r0
L_8c988e:
	mov_s r13,0x0
L_8c9890:
	stb r13,[gp, 0xb1]
L_8c9894:
	mov_s r14,r13
L_8c9896:
	b_s L_8c98a4
	.global L_8c9898
L_8c9898:
	bl.d L_8ccfd8
L_8c989c:
	mov_s r0,r14
L_8c989e:
	/* bl.d 0x008e27bc */
	.byte 0x22,0x0f,0x60,0x0c
L_8c98a2:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8c98a4
L_8c98a4:
	bl L_8ccec8
L_8c98a8:
	brlo r14,r0,L_8c9898
L_8c98ac:
	mov_s r14,0x847a3c
L_8c98b2:
	ldw r0,[r14, 0xa2]
L_8c98b6:
	cmp_s r0,0x0
L_8c98b8:
	bl.eq.d L_8ca388
L_8c98bc:
	mov.eq r0,r15
L_8c98c0:
	mov_s r1,0x1
L_8c98c2:
	stb r1,[r14, 0xa5]
L_8c98c6:
	mov_s r2,r14
L_8c98c8:
	mov_s r0,0x857700
L_8c98ce:
	st_s r2,[r0,0x44]
L_8c98d0:
	mov_s r0,0x800236
L_8c98d6:
	stb_s r1,[r0]
L_8c98d8:
	bl.d L_8da488
L_8c98dc:
	mov_s r0,0x0
L_8c98de:
	breq_s r0,0,L_8c98ea
L_8c98e0:
	bl.d L_8cc3dc
L_8c98e4:
	mov_s r0,0x0
L_8c98e6:
	bl L_8c2778
	.global L_8c98ea
L_8c98ea:
	mov lp_count,0x4
L_8c98ee:
	mov_s r1,0x8
L_8c98f0:
	lp L_8c9906
L_8c98f4:
	mov_s r0,0x801448
L_8c98fa:
	add2_s r0,r0,r1
L_8c98fc:
	st 0x989680,[r0]
L_8c9904:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8c9906
L_8c9906:
	bl L_8c3284
L_8c990a:
	mov_s r1,0x3e
L_8c990c:
	mov_s r2,0x4
L_8c990e:
	bl.d L_8e5204
L_8c9912:
	mov_s r3,0x0
L_8c9914:
	bl.d L_8c33d0
L_8c9918:
	mov_s r0,r15
L_8c991a:
	mov_s r1,r0
L_8c991c:
	stb_s r13,[r0]
L_8c991e:
	st_s r13,[sp,0x0]
L_8c9920:
	mov_s r0,r15
L_8c9922:
	mov_s r2,0x0
L_8c9924:
	mov_s r3,0x1a03
L_8c992a:
	mov r4,0x4
L_8c992e:
	mov r5,0x0
L_8c9932:
	mov r6,0x0
L_8c9936:
	bl.d L_8e4fc4
L_8c993a:
	mov r7,0x0
L_8c993e:
	b.d L_8c024c
L_8c9942:
	add_s sp,sp,0x4
