/* dti_alloc__dispatch @ 0x92b75c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1__on_event4
 * Зовёт сам: dti_alloc__scheduled_event_thunk, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dti_alloc__dispatch
dti_alloc__dispatch:
	.global L_92b75c
L_92b75c:
	push_s blink
L_92b75e:
	ld_s r1,[r0,0x38]
L_92b760:
	breq_s r1,0,L_92b778
L_92b762:
	cmp_s r1,0x1
L_92b764:
	cmp.ne r1,0x2
L_92b768:
	beq_s L_92b788
L_92b76a:
	mov_s r0,blink
L_92b76c:
	bl.d L_926618
L_92b770:
	mov r1,0x88
L_92b774:
	pop_s blink
L_92b776:
	j_s [blink]
	.global L_92b778
L_92b778:
	mov r0,blink
L_92b77c:
	bl.d L_926618
L_92b780:
	mov r1,0xab
L_92b784:
	pop_s blink
L_92b786:
	j_s [blink]
	.global L_92b788
L_92b788:
	bl.d L_92b794
L_92b78c:
	add r0,r0,0x20
L_92b790:
	pop_s blink
L_92b792:
	j_s [blink]
