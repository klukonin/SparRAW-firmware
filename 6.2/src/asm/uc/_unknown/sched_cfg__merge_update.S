/* sched_cfg__merge_update @ 0x9268c0, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwif_write_qh
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memcpy_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sched_cfg__merge_update
sched_cfg__merge_update:
	.global L_9268c0
L_9268c0:
	push_s blink
L_9268c2:
	bl L_920230
L_9268c6:
	mov_s r13,r0
L_9268c8:
	ldb_s r15,[r0,0x1]
L_9268ca:
	ldb_s r0,[gp,-0xed]
L_9268cc:
	mov_s r14,0x801be8
L_9268d2:
	breq_s r0,0,L_92693e
L_9268d4:
	bbit0 r15,0x4,L_9268ea
L_9268d8:
	ldw_s r0,[r13,0x2]
L_9268da:
	add2 r1,r13,0x11
L_9268de:
	stw_s r0,[r14,0x3a]
L_9268e0:
	add2 r0,r14,0x1f
L_9268e4:
	bl.d L_920330
L_9268e8:
	mov_s r2,0x30
	.global L_9268ea
L_9268ea:
	and.f 0x0,r15,0x21
L_9268ee:
	beq_s L_9268fc
L_9268f0:
	add r0,r14,0x3c
L_9268f4:
	add_s r1,r13,0x4
L_9268f6:
	bl.d L_920330
L_9268fa:
	mov_s r2,0x10
	.global L_9268fc
L_9268fc:
	bbit0 r15,0x1,L_92690e
L_926900:
	add2 r0,r14,0x13
L_926904:
	add r1,r13,0x14
L_926908:
	bl.d L_920330
L_92690c:
	mov_s r2,0x10
	.global L_92690e
L_92690e:
	bbit0 r15,0x2,L_926920
L_926912:
	add2 r0,r14,0x17
L_926916:
	add r1,r13,0x24
L_92691a:
	bl.d L_920330
L_92691e:
	mov_s r2,0x10
	.global L_926920
L_926920:
	bbit0 r15,0x3,L_926932
L_926924:
	add2 r0,r14,0x1b
L_926928:
	add r1,r13,0x34
L_92692c:
	bl.d L_920330
L_926930:
	mov_s r2,0x10
	.global L_926932
L_926932:
	ldb r0,[r14, 0x39]
L_926936:
	or_s r15,r15,r0
L_926938:
	stb r15,[r14, 0x39]
L_92693c:
	b_s L_926950
	.global L_92693e
L_92693e:
	add r0,r14,0x38
L_926942:
	mov_s r1,r13
L_926944:
	bl.d L_920330
L_926948:
	mov_s r2,0x74
L_92694a:
	mov_s r0,0x1
L_92694c:
	stb r0,[gp, -0xed]
	.global L_926950
L_926950:
	b L_92029c
