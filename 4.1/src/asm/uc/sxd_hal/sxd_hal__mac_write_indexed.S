/* sxd_hal__mac_write_indexed @ 0x9306ac, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sxd_hal.c
 * Зовут его: brp_flow_step, txss__init_sweep, txss__prepare_frames, txss_rx_step
 * Зовёт сам: uc_sysassert
 */
	.section .text.sxd_hal__mac_write_indexed,"ax",@progbits
	.global sxd_hal__mac_write_indexed
sxd_hal__mac_write_indexed:
	.global L_9306ac
L_9306ac:
	st.a r13,[sp,-0x10]
L_9306b0:
	st blink,[sp, 0x4]
L_9306b4:
	st_s r14,[sp,0x8]
L_9306b6:
	st_s r15,[sp,0xc]
L_9306b8:
	mov r14,r0
L_9306bc:
	and.f 0x0,r1,0xff000000
L_9306c4:
	bne.d L_930754
L_9306c8:
	mov r15,r1
	.global L_9306cc
L_9306cc:
	add1 r3,r14,0x29
L_9306d0:
	asl_s r3,r3,0x18
L_9306d2:
	mov_s r32,r3
L_9306d4:
	st.ab r3,[r25,0x4]
L_9306d8:
	bclr r25,r25,0xa
L_9306dc:
	add r6,r14,0x6
L_9306e0:
	mov r7,0x49000000
L_9306e8:
	bset r2,r7,r6
L_9306ec:
	mov r32,r2
L_9306f0:
	st.ab r2,[r25,0x4]
L_9306f4:
	bclr r25,r25,0xa
L_9306f8:
	add r4,r14,0x6
L_9306fc:
	mov r5,0x49000000
L_930704:
	bset r1,r5,r4
L_930708:
	mov r32,r1
L_93070c:
	st.ab r1,[r25,0x4]
L_930710:
	bclr r25,r25,0xa
L_930714:
	add r13,r14,0x4f
L_93071c:
	asl_s r13,r13,0x18
L_93071e:
	or_s r13,r13,r15
L_930720:
	mov r32,r13
L_930724:
	st.ab r13,[r25,0x4]
L_930728:
	bclr r25,r25,0xa
L_93072c:
	nop_s
L_93072e:
	nop_s
L_930730:
	nop_s
L_930732:
	add_s r14,r14,0x52
L_930734:
	asl_s r14,r14,0x18
L_930736:
	or r0,r14,0xb
L_93073a:
	mov_s r32,r0
L_93073c:
	st.ab r0,[r25,0x4]
L_930740:
	bclr r25,r25,0xa
L_930744:
	ld blink,[sp, 0x4]
L_930748:
	ld_s r14,[sp,0x8]
L_93074a:
	ld_s r15,[sp,0xc]
L_93074c:
	j.d [blink]
L_930750:
	ld.ab r13,[sp,0x10]
	.global L_930754
L_930754:
	mov_s r0,blink
L_930756:
	mov_s r2,0x1000d80
L_93075c:
	mov r1,0x51
L_930760:
	bl.d L_925548
L_930764:
	mov r3,0xd5
L_930768:
	b_s L_9306cc
L_93076a:
	nop_s
