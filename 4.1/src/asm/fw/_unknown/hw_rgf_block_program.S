/* hw_rgf_block_program @ 0x8cd794, 372 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, vring_hw__set_ready_bit
 */
	.section .text.hw_rgf_block_program,"ax",@progbits
	.global hw_rgf_block_program
hw_rgf_block_program:
	.global L_8cd794
L_8cd794:
	push_s blink
L_8cd796:
	bl L_8c02bc
L_8cd79a:
	mov_s r14,r0
L_8cd79c:
	mov_s r13,r1
L_8cd79e:
	bl.d L_8cd70c
L_8cd7a2:
	mov_s r16,r2
L_8cd7a4:
	mul64 r14,0x380
L_8cd7a8:
	add r1,mlo,0x4409980
L_8cd7b0:
	lsr_s r1,r1,0x3
L_8cd7b2:
	bic r1,r1,0x3
L_8cd7b6:
	st_s r13,[r1]
L_8cd7b8:
	add r1,mlo,0x44099c0
L_8cd7c0:
	lsr r2,r1,0x3
L_8cd7c4:
	bic r2,r2,0x3
L_8cd7c8:
	ld_s r13,[r2]
L_8cd7ca:
	bmsk_s r1,r1,0x4
L_8cd7cc:
	mov_s r3,0x0
L_8cd7ce:
	bset r3,r3,r1
L_8cd7d2:
	bic_s r13,r13,r3
L_8cd7d4:
	or_s r3,r3,r13
L_8cd7d6:
	st_s r3,[r2]
L_8cd7d8:
	add r1,mlo,0x44096d0
L_8cd7e0:
	bmsk_s r1,r1,0x4
L_8cd7e2:
	add_s r2,r1,0x4
L_8cd7e4:
	mov_s r3,0x0
L_8cd7e6:
	bset r3,r3,r2
L_8cd7ea:
	mov_s r13,0x0
L_8cd7ec:
	bset r13,r13,r1
L_8cd7f0:
	sub r2,r3,r13
L_8cd7f4:
	or_s r3,r3,r2
L_8cd7f6:
	asl r2,r16,r1
L_8cd7fa:
	and_s r3,r3,r2
L_8cd7fc:
	add r1,mlo,0x44096c0
L_8cd804:
	bmsk r13,r1,0x4
L_8cd808:
	add r2,mlo,0x44096c1
L_8cd810:
	bmsk_s r2,r2,0x4
L_8cd812:
	mov_s r15,0x0
L_8cd814:
	bset r15,r15,r2
L_8cd818:
	bset r4,r15,r13
L_8cd81c:
	add r13,mlo,0x44096c2
L_8cd824:
	bmsk_s r13,r13,0x4
L_8cd826:
	bset r2,r4,r13
L_8cd82a:
	add r0,mlo,0x44096c3
L_8cd832:
	bmsk_s r0,r0,0x4
L_8cd834:
	bset r2,r2,r0
L_8cd838:
	or_s r2,r2,r3
L_8cd83a:
	lsr_s r1,r1,0x3
L_8cd83c:
	st_s r2,[r1]
L_8cd83e:
	sync
L_8cd842:
	nop_s
L_8cd844:
	nop_s
L_8cd846:
	nop_s
L_8cd848:
	mul64 r14,0x380
L_8cd84c:
	mov_s r2,0x0
L_8cd84e:
	add r0,mlo,0x4409700
L_8cd856:
	bmsk r1,r0,0x4
L_8cd85a:
	bset r2,r2,r1
L_8cd85e:
	lsr_s r0,r0,0x3
L_8cd860:
	st_s r2,[r0]
L_8cd862:
	sync
L_8cd866:
	nop_s
L_8cd868:
	nop_s
L_8cd86a:
	nop_s
L_8cd86c:
	mul64 r14,0x380
L_8cd870:
	mov_s r1,0x0
L_8cd872:
	add r0,mlo,0x4409700
L_8cd87a:
	lsr_s r0,r0,0x3
L_8cd87c:
	st_s r1,[r0]
L_8cd87e:
	sync
L_8cd882:
	nop_s
L_8cd884:
	nop_s
L_8cd886:
	nop_s
L_8cd888:
	mul64 r14,0x380
L_8cd88c:
	mov_s r1,0x0
L_8cd88e:
	mov_s r13,0x0
L_8cd890:
	add r0,mlo,0x44096d0
L_8cd898:
	bmsk_s r0,r0,0x4
L_8cd89a:
	add_s r3,r0,0x4
L_8cd89c:
	bset r1,r1,r3
L_8cd8a0:
	bset r13,r13,r0
L_8cd8a4:
	sub r3,r1,r13
L_8cd8a8:
	or_s r3,r3,r1
L_8cd8aa:
	asl r13,r16,r0
L_8cd8ae:
	add r1,mlo,0x44096c1
L_8cd8b6:
	and_s r13,r13,r3
L_8cd8b8:
	bmsk_s r1,r1,0x4
L_8cd8ba:
	mov_s r3,0x0
L_8cd8bc:
	bset r3,r3,r1
L_8cd8c0:
	add r0,mlo,0x44096c0
L_8cd8c8:
	add r1,mlo,0x44096c2
L_8cd8d0:
	bmsk r4,r0,0x4
L_8cd8d4:
	bmsk_s r1,r1,0x4
L_8cd8d6:
	bset r3,r3,r4
L_8cd8da:
	bset r3,r3,r1
L_8cd8de:
	add r1,mlo,0x44096c3
L_8cd8e6:
	bmsk_s r1,r1,0x4
L_8cd8e8:
	bset r3,r3,r1
L_8cd8ec:
	add r1,mlo,0x44096c4
L_8cd8f4:
	or_s r3,r3,r13
L_8cd8f6:
	bmsk_s r1,r1,0x4
L_8cd8f8:
	bset r2,r3,r1
L_8cd8fc:
	lsr_s r0,r0,0x3
L_8cd8fe:
	st_s r2,[r0]
L_8cd900:
	sync
L_8cd904:
	b L_8c0324
