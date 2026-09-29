/* txss_func__reorder_sectors @ 0x937818, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txss_func.c
 * Зовут его: txss__flow_body, txss_flow_step_b
 * Зовёт сам: __ld_r18_to_r13_ret_uc, __st_r18_to_r13_uc, memcpy_uc, uc_sysassert
 */
	.section .text.txss_func__reorder_sectors,"ax",@progbits
	.global txss_func__reorder_sectors
txss_func__reorder_sectors:
	.global L_937818
L_937818:
	push_s blink
L_93781a:
	bl L_920204
L_93781e:
	sub_s sp,sp,0x3c
L_937820:
	mov_s r17,r0
L_937822:
	mov_s r18,r1
L_937824:
	mov_s r13,0x0
L_937826:
	mov_s r14,0x800fcc
L_93782c:
	add3 r16,r14,0x9
L_937830:
	mov_s r15,0x5
	.global L_937832
L_937832:
	rsub r0,r13,0x4
L_937836:
	ld.as r1,[r16,r0]
L_93783a:
	asl_s r0,r13,0x2
L_93783c:
	add1_s r0,r0,r0
L_93783e:
	add_s r0,r0,sp
L_937840:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_937842:
	add1_s r1,r1,r1
L_937844:
	add_s r1,r1,r14
L_937846:
	add_s r1,r1,0xc
L_937848:
	bl.d L_920310
L_93784c:
	mov_s r2,0xc
L_93784e:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_937850:
	/* brhs.d r15,0x1,0x00937832 */
	.byte 0xe3,0x0f,0x75,0x90
L_937854:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_937856:
	mov lp_count,0x5
L_93785a:
	mov_s r1,0x0
L_93785c:
	lp L_937868
L_937860:
	add2 r12,r16,r1
L_937864:
	st_s r1,[r12]
L_937866:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_937868
L_937868:
	add r0,r14,0xc
L_93786c:
	mov_s r1,sp
L_93786e:
	bl.d L_920310
L_937872:
	mov_s r2,0x3c
L_937874:
	breq r18,0x0,L_937890
L_937878:
	breq r18,0x1,L_9378b4
L_93787c:
	mov_s r0,blink
L_93787e:
	mov_s r2,0x1000c98
L_937884:
	mov_s r1,0x1f
L_937886:
	bl.d L_925548
L_93788a:
	mov r3,0x11d
L_93788e:
	b_s L_9378ca
	.global L_937890
L_937890:
	mul64 r17,0x3c
L_937894:
	add r1,r14,0xc
L_937898:
	add r0,mlo,0x85761c
L_9378a0:
	bl.d L_920310
L_9378a4:
	mov_s r2,0x3c
L_9378a6:
	ldb r1,[r14, 0x66]
L_9378aa:
	bset r1,r1,r17
L_9378ae:
	stb r1,[r14, 0x66]
L_9378b2:
	b_s L_9378ca
	.global L_9378b4
L_9378b4:
	mul64 r17,0x3c
L_9378b8:
	add r1,r14,0xc
L_9378bc:
	add r0,mlo,0x857400
L_9378c4:
	bl.d L_920310
L_9378c8:
	mov_s r2,0x3c
	.global L_9378ca
L_9378ca:
	b.d L_920264
L_9378ce:
	add_s sp,sp,0x3c
