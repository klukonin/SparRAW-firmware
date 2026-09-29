/* bti__dispatch_sweep_step @ 0x92b7dc, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_sm__action_935b4c
 * Зовёт сам: bi__run_bti_cycle, bti__prepare_sweep_set, l1_task__dispatch, uc_read_tsf_lo, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti__dispatch_sweep_step
bti__dispatch_sweep_step:
	.global L_92b7dc
L_92b7dc:
	st.a r13,[sp,-0xc]
L_92b7e0:
	st blink,[sp, 0x4]
L_92b7e4:
	st r14,[sp, 0x8]
L_92b7e8:
	bl.d L_935b9c
L_92b7ec:
	mov r13,r0
L_92b7f0:
	bl.d L_9364c8
L_92b7f4:
	mov r14,r0
L_92b7f8:
	brhs r14,0x7,L_92b838
L_92b7fc:
	ld.as r0,[0x801bc4,r14]
L_92b804:
	j_s [r0]
L_92b806:
	mov_s r0,0x1
	.global L_92b808
L_92b808:
	bl.d L_934e30
L_92b80c:
	mov r1,0x0
L_92b810:
	ld blink,[sp, 0x4]
L_92b814:
	ld_s r14,[sp,0x8]
L_92b816:
	j_s.d [blink]
L_92b818:
	ld.ab r13,[sp,0xc]
L_92b81c:
	b.d L_92b808
L_92b820:
	mov r0,0x6
L_92b824:
	bl.d L_928794
L_92b828:
	mov r0,r13
L_92b82c:
	ld blink,[sp, 0x4]
L_92b830:
	ld_s r14,[sp,0x8]
L_92b832:
	j_s.d [blink]
L_92b834:
	ld.ab r13,[sp,0xc]
	.global L_92b838
L_92b838:
	mov r0,blink
L_92b83c:
	bl.d L_926618
L_92b840:
	mov r1,0x76
L_92b844:
	ld blink,[sp, 0x4]
L_92b848:
	ld_s r14,[sp,0x8]
L_92b84a:
	j_s.d [blink]
L_92b84c:
	ld.ab r13,[sp,0xc]
L_92b850:
	ld blink,[sp, 0x4]
L_92b854:
	ld_s r14,[sp,0x8]
L_92b856:
	j_s.d [blink]
L_92b858:
	ld.ab r13,[sp,0xc]
