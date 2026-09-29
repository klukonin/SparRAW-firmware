/* ese__peer_cid_by_aid @ 0x8cc9c8, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ese__alloc_to_slot, schedule__build_allocation_entry
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mid__cid_by_aid, mid__state_is_2_or_3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ese__peer_cid_by_aid
ese__peer_cid_by_aid:
	.global L_8cc9c8
L_8cc9c8:
	push_s blink
L_8cc9ca:
	bl L_8c01dc
L_8cc9ce:
	mov_s r15,r0
L_8cc9d0:
	mov_s r14,r1
L_8cc9d2:
	mov_s r16,r2
L_8cc9d4:
	mov_s r13,0x0
L_8cc9d6:
	bl.d L_8da488
L_8cc9da:
	mov_s r0,r13
L_8cc9dc:
	cmp_s r0,0x0
L_8cc9de:
	ld_s r1,[r15,0x10]
L_8cc9e0:
	ldb_s r0,[r1,0x8]
L_8cc9e2:
	beq_s L_8cc9fa
L_8cc9e4:
	cmp_s r14,r0
L_8cc9e6:
	mov_s r12,0xff
L_8cc9e8:
	cmp.ne r14,r12
L_8cc9ec:
	mov.eq r13,0x1
L_8cc9f0:
	extb.f 0x0,r13
L_8cc9f4:
	mov_s r0,r1
L_8cc9f6:
	beq_s L_8cca0e
L_8cc9f8:
	b_s L_8cca12
	.global L_8cc9fa
L_8cc9fa:
	cmp_s r14,r0
L_8cc9fc:
	mov_s r12,0xff
L_8cc9fe:
	cmp.ne r14,r12
L_8cca02:
	mov.eq r13,0x1
L_8cca06:
	extb.f 0x0,r13
L_8cca0a:
	mov_s r0,r1
L_8cca0c:
	beq_s L_8cca12
	.global L_8cca0e
L_8cca0e:
	mov_s r1,r14
L_8cca10:
	b_s L_8cca14
	.global L_8cca12
L_8cca12:
	mov_s r1,r16
	.global L_8cca14
L_8cca14:
	bl L_8cc06c
L_8cca18:
	b.d L_8c0244
L_8cca1c:
	extb_s r0,r0
L_8cca1e:
	nop_s
