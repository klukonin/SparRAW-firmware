/* cxx__vec_new @ 0x8c1700, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_handler_ptrs
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, cxx__vec_nop_ctor_thunk, mem_pool__tag_block
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global cxx__vec_new
cxx__vec_new:
	.global L_8c1700
L_8c1700:
	push_s blink
L_8c1702:
	bl L_8c01d0
L_8c1706:
	mov_s r14,r0
L_8c1708:
	mov_s r15,r1
L_8c170a:
	mov_s r17,r2
L_8c170c:
	mov_s r19,r3
L_8c170e:
	mov r16,r4
L_8c1712:
	mov_s r13,0x0
L_8c1714:
	bbit0 r4,0x0,L_8c173e
L_8c1718:
	lsr r0,r16,0x8
L_8c171c:
	mov_s r1,0x8
L_8c171e:
	cmp_s r0,0x8
L_8c1720:
	mov.cc r0,r1
L_8c1724:
	mov_s r2,0x4
L_8c1726:
	cmp_s r0,0x4
L_8c1728:
	mov.ls r13,r2
L_8c172c:
	mov.hi r13,r0
L_8c1730:
	brhs 0xffff,r15,L_8c173e
L_8c1738:
	cmp_s r13,0x8
L_8c173a:
	mov.ls r13,r1
	.global L_8c173e
L_8c173e:
	btst r16,0x6
L_8c1742:
	mov_s r1,0x1
L_8c1744:
	sub.eq r1,r1,r1
L_8c1748:
	asl r18,r1,0x2
L_8c174c:
	brne_s r14,0,L_8c175e
L_8c174e:
	mulu64 r17,r15
L_8c1752:
	add r0,mlo,r13
L_8c1756:
	bl.d L_8c1cd0
L_8c175a:
	add2_s r0,r0,r1
L_8c175c:
	mov_s r14,r0
	.global L_8c175e
L_8c175e:
	mov_s r0,r13
L_8c1760:
	mov_s r1,r14
L_8c1762:
	bl.d L_8e7474
L_8c1766:
	mov_s r2,r15
L_8c1768:
	mov_s r14,r0
L_8c176a:
	btst r16,0x1
L_8c176e:
	cmp.ne r14,0x0
L_8c1772:
	mov.eq r13,r14
L_8c1776:
	beq_s L_8c178e
L_8c1778:
	brlo.d r15,0x1,L_8c178e
L_8c177c:
	mov_s r13,r14
	.global L_8c177e
L_8c177e:
	mov_s r0,r13
L_8c1780:
	jl.d [r19]
L_8c1784:
	mov_s r1,0x0
L_8c1786:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8c1788:
	brhs.d r15,0x1,L_8c177e
L_8c178c:
	add_s r13,r13,r17
	.global L_8c178e
L_8c178e:
	breq r18,0x0,L_8c1796
L_8c1792:
	ld_s r0,[r14]
L_8c1794:
	st_s r0,[r13]
	.global L_8c1796
L_8c1796:
	b.d L_8c022c
L_8c179a:
	mov_s r0,r14
