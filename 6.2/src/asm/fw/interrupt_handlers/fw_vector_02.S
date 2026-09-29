/* fw_vector_02 @ 0x8c0774, 380 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: fw_sysassert_fatal, instruction_error__report
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_02
fw_vector_02:
	.global L_8c0774
L_8c0774:
	push_s r12
L_8c0776:
	st.a mhi,[sp,-0x4]
L_8c077a:
	st.a mlo,[sp,-0x4]
L_8c077e:
	push_s r0
L_8c0780:
	push_s r1
L_8c0782:
	push_s r2
L_8c0784:
	push_s r3
L_8c0786:
	st.a r4,[sp,-0x4]
L_8c078a:
	st.a r5,[sp,-0x4]
L_8c078e:
	st.a r6,[sp,-0x4]
L_8c0792:
	st.a r7,[sp,-0x4]
L_8c0796:
	st.a r8,[sp,-0x4]
L_8c079a:
	st.a r9,[sp,-0x4]
L_8c079e:
	st.a r10,[sp,-0x4]
L_8c07a2:
	st.a r11,[sp,-0x4]
L_8c07a6:
	push_s r13
L_8c07a8:
	push_s r14
L_8c07aa:
	push_s r15
L_8c07ac:
	st.a r16,[sp,-0x4]
L_8c07b0:
	st.a r17,[sp,-0x4]
L_8c07b4:
	st.a r18,[sp,-0x4]
L_8c07b8:
	st.a r19,[sp,-0x4]
L_8c07bc:
	st.a r20,[sp,-0x4]
L_8c07c0:
	st.a r21,[sp,-0x4]
L_8c07c4:
	st.a r22,[sp,-0x4]
L_8c07c8:
	st.a r23,[sp,-0x4]
L_8c07cc:
	st.a r24,[sp,-0x4]
L_8c07d0:
	st.a r25,[sp,-0x4]
L_8c07d4:
	st.a lp_count,[sp,-0x4]
L_8c07d8:
	lr r12,[0x2]
L_8c07dc:
	push_s r12
L_8c07de:
	lr r12,[0x3]
L_8c07e2:
	push_s r12
L_8c07e4:
	push_s blink
L_8c07e6:
	st.a r0,[sp,-0x80]
L_8c07ea:
	st_s r1,[sp,0x4]
L_8c07ec:
	st_s r2,[sp,0x8]
L_8c07ee:
	st_s r3,[sp,0xc]
L_8c07f0:
	st r4,[sp, 0x10]
L_8c07f4:
	st r5,[sp, 0x14]
L_8c07f8:
	st r6,[sp, 0x18]
L_8c07fc:
	st r7,[sp, 0x1c]
L_8c0800:
	st r8,[sp, 0x20]
L_8c0804:
	st r9,[sp, 0x24]
L_8c0808:
	st r10,[sp, 0x28]
L_8c080c:
	st r11,[sp, 0x2c]
L_8c0810:
	st_s r12,[sp,0x30]
L_8c0812:
	st_s r13,[sp,0x34]
L_8c0814:
	st_s r14,[sp,0x38]
L_8c0816:
	st_s r15,[sp,0x3c]
L_8c0818:
	st r16,[sp, 0x40]
L_8c081c:
	st r17,[sp, 0x44]
L_8c0820:
	st r18,[sp, 0x48]
L_8c0824:
	st r19,[sp, 0x4c]
L_8c0828:
	st r20,[sp, 0x50]
L_8c082c:
	st r21,[sp, 0x54]
L_8c0830:
	st r22,[sp, 0x58]
L_8c0834:
	st r23,[sp, 0x5c]
L_8c0838:
	st r24,[sp, 0x60]
L_8c083c:
	st r25,[sp, 0x64]
L_8c0840:
	st gp,[sp, 0x68]
L_8c0844:
	st sp,[sp, 0x6c]
L_8c0848:
	st sp,[sp, 0x70]
L_8c084c:
	st ilink1,[sp, 0x74]
L_8c0850:
	st ilink2,[sp, 0x78]
L_8c0854:
	st blink,[sp, 0x7c]
L_8c0858:
	mov_s r0,blink
L_8c085a:
	mov_s r1,ilink2
L_8c085c:
	bl.d L_8c442c
L_8c0860:
	mov_s r2,sp
L_8c0862:
	mov_s r0,blink
L_8c0864:
	mov_s r1,0x11a8
L_8c086a:
	bl L_8c9b28
L_8c086e:
	add sp,sp,0x80
L_8c0872:
	pop_s blink
L_8c0874:
	pop_s r12
L_8c0876:
	sr r12,[0x3]
L_8c087a:
	pop_s r12
L_8c087c:
	sr r12,[0x2]
L_8c0880:
	pop_s r12
L_8c0882:
	mov_s lp_count,r12
L_8c0884:
	ld.ab r25,[sp,0x4]
L_8c0888:
	ld.ab r24,[sp,0x4]
L_8c088c:
	ld.ab r23,[sp,0x4]
L_8c0890:
	ld.ab r22,[sp,0x4]
L_8c0894:
	ld.ab r21,[sp,0x4]
L_8c0898:
	ld.ab r20,[sp,0x4]
L_8c089c:
	ld.ab r19,[sp,0x4]
L_8c08a0:
	ld.ab r18,[sp,0x4]
L_8c08a4:
	ld.ab r17,[sp,0x4]
L_8c08a8:
	ld.ab r16,[sp,0x4]
L_8c08ac:
	pop_s r15
L_8c08ae:
	pop_s r14
L_8c08b0:
	pop_s r13
L_8c08b2:
	ld.ab r11,[sp,0x4]
L_8c08b6:
	ld.ab r10,[sp,0x4]
L_8c08ba:
	ld.ab r9,[sp,0x4]
L_8c08be:
	ld.ab r8,[sp,0x4]
L_8c08c2:
	ld.ab r7,[sp,0x4]
L_8c08c6:
	ld.ab r6,[sp,0x4]
L_8c08ca:
	ld.ab r5,[sp,0x4]
L_8c08ce:
	ld.ab r4,[sp,0x4]
L_8c08d2:
	pop_s r3
L_8c08d4:
	pop_s r2
L_8c08d6:
	pop_s r1
L_8c08d8:
	pop_s r0
L_8c08da:
	pop_s r12
L_8c08dc:
	mulu64 r12,0x1
L_8c08e0:
	mov 0x0,mlo
L_8c08e4:
	pop_s r12
L_8c08e6:
	sr r12,[0x12]
L_8c08ea:
	pop_s r12
L_8c08ec:
	j.f [ilink1]
