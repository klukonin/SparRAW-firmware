/* mem_pool__create @ 0x8c16d0, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__init_8053b0, mem_pool__init_847df0
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, mem_pool__tag_block, tail_stub_ret_8c1a74
 */
	.section .text.mem_pool__create,"ax",@progbits
	.global mem_pool__create
mem_pool__create:
	.global L_8c16d0
L_8c16d0:
	push_s blink
L_8c16d2:
	bl L_8c02b0
L_8c16d6:
	mov_s r14,r0
L_8c16d8:
	mov_s r15,r1
L_8c16da:
	mov_s r17,r2
L_8c16dc:
	mov_s r19,r3
L_8c16de:
	mov r16,r4
L_8c16e2:
	mov_s r13,0x0
L_8c16e4:
	bbit0 r4,0x0,L_8c170e
L_8c16e8:
	lsr r0,r16,0x8
L_8c16ec:
	mov_s r1,0x8
L_8c16ee:
	cmp_s r0,0x8
L_8c16f0:
	mov.cc r0,r1
L_8c16f4:
	mov_s r2,0x4
L_8c16f6:
	cmp_s r0,0x4
L_8c16f8:
	mov.ls r13,r2
L_8c16fc:
	mov.hi r13,r0
L_8c1700:
	brhs 0xffff,r15,L_8c170e
L_8c1708:
	cmp_s r13,0x8
L_8c170a:
	mov.ls r13,r1
	.global L_8c170e
L_8c170e:
	btst r16,0x6
L_8c1712:
	mov_s r1,0x1
L_8c1714:
	sub.eq r1,r1,r1
L_8c1718:
	asl r18,r1,0x2
L_8c171c:
	brne_s r14,0,L_8c172e
L_8c171e:
	mulu64 r17,r15
L_8c1722:
	add r0,mlo,r13
L_8c1726:
	bl.d L_8c1a70
L_8c172a:
	add2_s r0,r0,r1
L_8c172c:
	mov_s r14,r0
	.global L_8c172e
L_8c172e:
	mov_s r0,r13
L_8c1730:
	mov_s r1,r14
L_8c1732:
	bl.d L_8e2344
L_8c1736:
	mov_s r2,r15
L_8c1738:
	mov_s r14,r0
L_8c173a:
	btst r16,0x1
L_8c173e:
	cmp.ne r14,0x0
L_8c1742:
	mov.eq r13,r14
L_8c1746:
	beq_s L_8c175e
L_8c1748:
	brlo.d r15,0x1,L_8c175e
L_8c174c:
	mov_s r13,r14
	.global L_8c174e
L_8c174e:
	mov_s r0,r13
L_8c1750:
	jl.d [r19]
L_8c1754:
	mov_s r1,0x0
L_8c1756:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8c1758:
	brhs.d r15,0x1,L_8c174e
L_8c175c:
	add_s r13,r13,r17
	.global L_8c175e
L_8c175e:
	breq r18,0x0,L_8c1766
L_8c1762:
	ld_s r0,[r14]
L_8c1764:
	st_s r0,[r13]
	.global L_8c1766
L_8c1766:
	b.d L_8c030c
L_8c176a:
	mov_s r0,r14
