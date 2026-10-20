/* l1_task__select_by_mode @ 0x921840, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf__abort_step, bf_sm__set_sta_state, uc_read_tsf_lo
 * Глобалы (через gp): 0x8005dc, 0x8005e0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__select_by_mode
l1_task__select_by_mode:
	.global L_921840
L_921840:
	push_s blink
L_921842:
	bl L_920234
L_921846:
	mov_s r2,0x801ffc
L_92184c:
	ld r0,[r2, 0xc0]
L_921850:
	mov_s r1,0x8020b4
L_921856:
	bmsk_s r0,r0,0x2
L_921858:
	ldb_s r13,[r1,r0]
L_92185a:
	asl_s r0,r13,0x2
L_92185c:
	add2_s r0,r0,r0
L_92185e:
	ld_s r0,[r2,r0]
L_921860:
	brne r0,0x12,L_9218ae
L_921864:
	bl L_9364c8
L_921868:
	mov_s r2,0x80207c
L_92186e:
	ld_s r1,[r2,0x74]
L_921870:
	mov_s r14,0x800688
L_921876:
	sub_s r0,r0,r1
L_921878:
	cmp r0,0x3e8
L_92187c:
	st_s r0,[r2,0x78]
L_92187e:
	ld_s r1,[r14]
L_921880:
	bls_s L_9218a8
L_921882:
	mov_s r0,0x0
L_921884:
	st_s r0,[r14]
L_921886:
	ld_s r0,[gp,0xb8]
L_921888:
	st_s r1,[r14,0x4]
L_92188a:
	brne r0,0x1,L_92189a
L_92188e:
	ld_s r0,[gp,0xb4]
L_921890:
	cmp_s r0,0x1
L_921892:
	mov.ne r0,r13
L_921896:
	mov_s r1,0x2
L_921898:
	bne_s L_92189e
	.global L_92189a
L_92189a:
	mov_s r0,r13
L_92189c:
	mov_s r1,0x11
	.global L_92189e
L_92189e:
	bl L_92b220
L_9218a2:
	bl.d L_921824
L_9218a6:
	mov_s r0,r13
	.global L_9218a8
L_9218a8:
	ld_s r0,[r14]
L_9218aa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9218ac:
	st_s r0,[r14]
	.global L_9218ae
L_9218ae:
	b L_9202a4
L_9218b2:
	nop_s
