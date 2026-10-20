/* bi__bti_timer_step @ 0x92e7c8, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bi__run_bti_cycle, l1_task__dispatch, uc_read_tsf_lo, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi__bti_timer_step
bi__bti_timer_step:
L_92e7c8:
	st.a r13,[sp,-0xc]
L_92e7cc:
	st blink,[sp, 0x4]
L_92e7d0:
	st_s r14,[sp,0x8]
L_92e7d2:
	mov_s r14,r0
L_92e7d4:
	bl.d L_9364c8
L_92e7d8:
	mov r13,r1
L_92e7dc:
	brhs r13,0x7,L_92e81c
L_92e7e0:
	ld.as r0,[0x801ba8,r13]
L_92e7e8:
	j_s [r0]
L_92e7ea:
	mov_s r0,0x1
	.global L_92e7ec
L_92e7ec:
	bl.d L_934e30
L_92e7f0:
	mov r1,0x0
L_92e7f4:
	ld blink,[sp, 0x4]
L_92e7f8:
	ld_s r14,[sp,0x8]
L_92e7fa:
	j_s.d [blink]
L_92e7fc:
	ld.ab r13,[sp,0xc]
L_92e800:
	b.d L_92e7ec
L_92e804:
	mov r0,0x6
L_92e808:
	bl.d L_928794
L_92e80c:
	mov r0,r14
L_92e810:
	ld blink,[sp, 0x4]
L_92e814:
	ld_s r14,[sp,0x8]
L_92e816:
	j_s.d [blink]
L_92e818:
	ld.ab r13,[sp,0xc]
	.global L_92e81c
L_92e81c:
	mov r0,blink
L_92e820:
	bl.d L_926618
L_92e824:
	mov r1,0x76
L_92e828:
	ld blink,[sp, 0x4]
L_92e82c:
	ld_s r14,[sp,0x8]
L_92e82e:
	j_s.d [blink]
L_92e830:
	ld.ab r13,[sp,0xc]
L_92e834:
	ld blink,[sp, 0x4]
L_92e838:
	ld_s r14,[sp,0x8]
L_92e83a:
	j_s.d [blink]
L_92e83c:
	ld.ab r13,[sp,0xc]
