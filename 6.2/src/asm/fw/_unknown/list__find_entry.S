/* list__find_entry @ 0x8c2638, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__insert_timer
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, list__find_entry_b, list__find_entry_c, list__find_entry_d
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global list__find_entry
list__find_entry:
	.global L_8c2638
L_8c2638:
	push_s blink
L_8c263a:
	bl L_8c01d8
L_8c263e:
	mov.f r14,r1
L_8c2642:
	mov_s r15,r0
L_8c2644:
	mov_s r17,r2
L_8c2646:
	beq_s L_8c2682
	.global L_8c2648
L_8c2648:
	breq r17,0x0,L_8c268c
	.global L_8c264c
L_8c264c:
	ld_s r0,[r15]
L_8c264e:
	cmp_s r0,0x0
L_8c2650:
	mov_s r0,0x1
L_8c2652:
	sub_s.ne r0,r0,r0
L_8c2654:
	extb.f 0x0,r0
L_8c2658:
	bne_s L_8c269a
L_8c265a:
	ld_s r13,[r15,0x4]
L_8c265c:
	mov r16,0x0
L_8c2660:
	b_s L_8c2666
	.global L_8c2662
L_8c2662:
	mov_s r16,r13
L_8c2664:
	mov_s r13,r0
	.global L_8c2666
L_8c2666:
	ld_s r0,[r13,0x8]
L_8c2668:
	mov_s r2,r17
L_8c266a:
	jl_s.d [r2]
L_8c266c:
	ld_s r1,[r14,0x8]
L_8c266e:
	cmp r0,-0x1
L_8c2672:
	bne_s L_8c2696
L_8c2674:
	ld_s r0,[r13]
L_8c2676:
	brne_s r0,0,L_8c2662
L_8c2678:
	mov_s r0,r15
L_8c267a:
	bl.d L_8c25f4
L_8c267e:
	mov_s r1,r14
L_8c2680:
	b_s L_8c26ae
	.global L_8c2682
L_8c2682:
	mov_s r0,blink
L_8c2684:
	bl.d L_8c9b28
L_8c2688:
	mov_s r1,0xf2
L_8c268a:
	b_s L_8c2648
	.global L_8c268c
L_8c268c:
	mov_s r0,blink
L_8c268e:
	bl.d L_8c9b28
L_8c2692:
	mov_s r1,0xf3
L_8c2694:
	b_s L_8c264c
	.global L_8c2696
L_8c2696:
	brne r16,0x0,L_8c26a4
	.global L_8c269a
L_8c269a:
	mov_s r0,r15
L_8c269c:
	bl.d L_8c25b0
L_8c26a0:
	mov_s r1,r14
L_8c26a2:
	b_s L_8c26ae
	.global L_8c26a4
L_8c26a4:
	mov_s r0,r15
L_8c26a6:
	mov_s r1,r14
L_8c26a8:
	bl.d L_8c26b4
L_8c26ac:
	mov_s r2,r16
	.global L_8c26ae
L_8c26ae:
	b L_8c023c
L_8c26b2:
	nop_s
