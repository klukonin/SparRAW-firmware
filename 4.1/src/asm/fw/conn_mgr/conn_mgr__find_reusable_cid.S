/* conn_mgr__find_reusable_cid @ 0x8c589c, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   No CID index to reuse found.
 *   conn_mgr.cpp
 *   Found linked CID %d to reuse, state %x.
 * Зовут его: conn_mgr__alloc_cid
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn_mgr__link_down_evt, fw_log__emit0, fw_log__emit2, fw_sysassert_fatal, iter__has_more, iter__init, iter__next, llist__remove, mem_pool__free
 */
	.section .text.conn_mgr__find_reusable_cid,"ax",@progbits
	.global conn_mgr__find_reusable_cid
conn_mgr__find_reusable_cid:
	.global L_8c589c
L_8c589c:
	push_s blink
L_8c589e:
	bl L_8c02bc
L_8c58a2:
	sub_s sp,sp,0x4
L_8c58a4:
	mov_s r15,sp
L_8c58a6:
	mov r16,0x80461c
L_8c58ae:
	mov_s r0,r15
L_8c58b0:
	bl.d L_8e1138
L_8c58b4:
	mov_s r1,r16
L_8c58b6:
	b_s L_8c58ce
	.global L_8c58b8
L_8c58b8:
	bl.d L_8db188
L_8c58bc:
	mov_s r0,r15
L_8c58be:
	ld_s r13,[r0,0x8]
L_8c58c0:
	mov_s r14,r0
L_8c58c2:
	breq_s r13,0,L_8c58e8
	.global L_8c58c4
L_8c58c4:
	ld_s r0,[r14,0x8]
L_8c58c6:
	ldb r4,[r0, 0xfc]
L_8c58ca:
	brlo r4,0x4,L_8c58fe
	.global L_8c58ce
L_8c58ce:
	bl.d L_8cb674
L_8c58d2:
	mov_s r0,r15
L_8c58d4:
	brne_s r0,0,L_8c58b8
L_8c58d6:
	mov_s r2,0x100a8a4
L_8c58dc:
	mov_s r0,0xb
L_8c58de:
	bl.d L_8edfb0
L_8c58e2:
	mov_s r1,0x1
L_8c58e4:
	mov_s r0,0x0
L_8c58e6:
	b_s L_8c5930
	.global L_8c58e8
L_8c58e8:
	mov_s r0,blink
L_8c58ea:
	mov_s r2,0x100a878
L_8c58f0:
	mov_s r1,0xd2
L_8c58f2:
	bset_s r1,r1,0xc
L_8c58f4:
	bl.d L_8c82c0
L_8c58f8:
	mov r3,0x117
L_8c58fc:
	b_s L_8c58c4
	.global L_8c58fe
L_8c58fe:
	ld_s r0,[r13,0x3c]
L_8c5900:
	brne_s r0,0,L_8c58ce
L_8c5902:
	mov_s r2,0x100a8c4
L_8c5908:
	mov_s r0,0xb
L_8c590a:
	mov_s r1,0x2
L_8c590c:
	bl.d L_8edff8
L_8c5910:
	ldb_s r3,[r13,0x8]
L_8c5912:
	mov_s r0,r16
L_8c5914:
	bl.d L_8de4ec
L_8c5918:
	mov_s r1,r14
L_8c591a:
	mov_s r0,0x0
L_8c591c:
	st_s r0,[r14,0x8]
L_8c591e:
	add2 r0,r16,0x1b
L_8c5922:
	bl.d L_8c9268
L_8c5926:
	mov_s r1,r14
L_8c5928:
	bl.d L_8d79cc
L_8c592c:
	mov_s r0,r13
L_8c592e:
	mov_s r0,0x1
	.global L_8c5930
L_8c5930:
	b.d L_8c0324
L_8c5934:
	add_s sp,sp,0x4
L_8c5936:
	nop_s
