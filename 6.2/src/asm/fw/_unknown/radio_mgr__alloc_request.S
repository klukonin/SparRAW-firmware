/* radio_mgr__alloc_request @ 0x8e2724, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pbss_sta_list_update
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, radio_mgr__unlink_request, stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_mgr__alloc_request
radio_mgr__alloc_request:
	.global L_8e2724
L_8e2724:
	mul64 r1,0x11
L_8e2728:
	add_s r0,r0,0x75
L_8e272a:
	mov_s r2,0x8
L_8e272c:
	add_s r0,r0,mlo
L_8e272e:
	j_s.d [blink]
L_8e2730:
	stb_s r2,[r0]
L_8e2732:
	nop_s
L_8e2734:
	push_s blink
L_8e2736:
	bl L_8c01e4
L_8e273a:
	mov.f r13,r1
L_8e273e:
	mov_s r14,r0
L_8e2740:
	beq_s L_8e275c
	.global L_8e2742
L_8e2742:
	add r0,r14,0x18
L_8e2746:
	bl.d L_8e2778
L_8e274a:
	mov_s r1,r13
L_8e274c:
	breq_s r0,0,L_8e276a
L_8e274e:
	mov_s r0,0x0
L_8e2750:
	st_s r0,[r13,0x8]
L_8e2752:
	add_s r0,r14,0x4
L_8e2754:
	bl.d L_8caed0
L_8e2758:
	mov_s r1,r13
L_8e275a:
	b_s L_8e2774
	.global L_8e275c
L_8e275c:
	mov_s r0,blink
L_8e275e:
	mov_s r1,0x115f
L_8e2764:
	bl L_8c9b28
L_8e2768:
	b_s L_8e2742
	.global L_8e276a
L_8e276a:
	ld_s r0,[r14]
L_8e276c:
	ld_s r2,[r0,0x10]
L_8e276e:
	mov_s r0,r14
L_8e2770:
	jl_s.d [r2]
L_8e2772:
	mov_s r1,r13
	.global L_8e2774
L_8e2774:
	b L_8c0254
