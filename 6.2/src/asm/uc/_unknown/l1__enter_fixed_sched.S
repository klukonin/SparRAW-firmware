/* l1__enter_fixed_sched @ 0x92c7ec, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__main_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac__read_tsf64_uc, mac__set_slot_mask_924000, rx_mode__configure, rx_nav__clear_flags, uc_evt__send_30
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1__enter_fixed_sched
l1__enter_fixed_sched:
	.global L_92c7ec
L_92c7ec:
	push_s blink
L_92c7ee:
	bl L_920230
L_92c7f2:
	sub_s sp,sp,0x8
L_92c7f4:
	mov_s r15,r0
L_92c7f6:
	mov_s r14,0x0
L_92c7f8:
	bl.d L_9267d4
L_92c7fc:
	st.as r14,[gp,-0x33]
L_92c800:
	bl L_92dc1c
L_92c804:
	mov_s r13,0x8014a4
L_92c80a:
	ld_s r0,[r13,0x1c]
L_92c80c:
	st_s r14,[sp,0x4]
L_92c80e:
	cmp_s r0,0x0
L_92c810:
	mov_s r0,0x1
L_92c812:
	sub_s.ne r0,r0,r0
L_92c814:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92c816:
	st.as r0,[gp,-0xd]
L_92c81a:
	st_s r14,[sp,0x0]
L_92c81c:
	bl.d L_927784
L_92c820:
	mov_s r0,sp
L_92c822:
	ld_s r0,[r13,0x1c]
L_92c824:
	brne_s r0,0,L_92c838
L_92c826:
	mov_s r0,0x2
L_92c828:
	bl.d L_92f4bc
L_92c82c:
	mov_s r1,r15
L_92c82e:
	mov_s r0,0x801c18
L_92c834:
	bl L_9356cc
	.global L_92c838
L_92c838:
	b.d L_92029c
L_92c83c:
	add_s sp,sp,0x8
L_92c83e:
	nop_s
