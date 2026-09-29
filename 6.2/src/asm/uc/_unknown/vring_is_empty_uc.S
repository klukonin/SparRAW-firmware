/* vring_is_empty_uc @ 0x92a6f0, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_is_empty: sw_head:0x%x, sw_tail:0x%x
 * Зовут его: boot_uc__init_g800610, vring__is_empty_uc_quiet
 * Зовёт сам: uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global vring_is_empty_uc
vring_is_empty_uc:
	.global L_92a6f0
L_92a6f0:
	st r0,[0x880010]
L_92a6f8:
	j_s [blink]
L_92a6fa:
	nop_s
	.global L_92a6fc
L_92a6fc:
	st.a r13,[sp,-0xc]
L_92a700:
	st_s r14,[sp,0x8]
L_92a702:
	asl_s r0,r0,0x8
L_92a704:
	add r3,r0,0x440c0c0
L_92a70c:
	lsr_s r3,r3,0x3
L_92a70e:
	bic r3,r3,0x3
L_92a712:
	ld_s r14,[r3]
L_92a714:
	add_s r0,r0,0x440c100
L_92a71a:
	lsr r2,r0,0x3
L_92a71e:
	bic r2,r2,0x3
L_92a722:
	ld_s r13,[r2]
L_92a724:
	breq.d r1,0x0,L_92a740
L_92a728:
	st blink,[sp, 0x4]
L_92a72c:
	mov_s r1,0x1002d14
L_92a732:
	mov_s r0,0x20
L_92a734:
	mov r2,r14
L_92a738:
	bl.d L_92d27c
L_92a73c:
	mov r3,r13
	.global L_92a740
L_92a740:
	ld blink,[sp, 0x4]
L_92a744:
	cmp_s r14,r13
L_92a746:
	mov_s r0,0x1
L_92a748:
	ld_s r14,[sp,0x8]
L_92a74a:
	sub_s.ne r0,r0,r0
L_92a74c:
	j.d [blink]
L_92a750:
	ld.ab r13,[sp,0xc]
