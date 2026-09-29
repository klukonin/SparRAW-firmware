/* ka__check_peer_state @ 0x8c67f0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_necessity_detector__start_monitoring, lm_if__stop_link_a
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, ll_detector__is_armed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ka__check_peer_state
ka__check_peer_state:
	.global L_8c67f0
L_8c67f0:
	push_s blink
L_8c67f2:
	bl L_8c01e4
L_8c67f6:
	bl.d L_8da35c
L_8c67fa:
	mov_s r14,r0
L_8c67fc:
	breq_s r0,0,L_8c682c
L_8c67fe:
	add r13,r14,0x20
L_8c6802:
	ldb_s r0,[r13,0x10]
L_8c6804:
	brge r0,0x8,L_8c6834
	.global L_8c6808
L_8c6808:
	ldb_s r1,[r13,0x10]
L_8c680a:
	ld_s r0,[r14,0x34]
L_8c680c:
	asl_s r2,r1,0x2
L_8c680e:
	add r3,r0,0xc
L_8c6812:
	add3_s r2,r2,r2
L_8c6814:
	add r0,r0,0x1a4
L_8c6818:
	ld_s r2,[r3,r2]
L_8c681a:
	add2_s r0,r0,r1
L_8c681c:
	st_s r2,[r0]
L_8c681e:
	ld_s r0,[r14,0x34]
L_8c6820:
	mov_s r2,0x0
L_8c6822:
	ldb_s r1,[r13,0x10]
L_8c6824:
	add r0,r0,0x184
L_8c6828:
	add2_s r0,r0,r1
L_8c682a:
	st_s r2,[r0]
	.global L_8c682c
L_8c682c:
	mov_s r0,0x0
L_8c682e:
	b.d L_8c0254
L_8c6832:
	st_s r0,[r14,0x38]
	.global L_8c6834
L_8c6834:
	mov_s r0,blink
L_8c6836:
	mov_s r1,0x1548
L_8c683c:
	bl L_8c9b28
L_8c6840:
	b_s L_8c6808
L_8c6842:
	nop_s
