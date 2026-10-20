/* maintain_sm__action_8c48f8 @ 0x8c48f8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, conn__get_cid_of_obj, lmac_if_trigger_bf, maintain_sm__release_radio_after_bf_evt, sm__defer_call
 * Глобалы (через gp): 0x800251
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8c48f8
maintain_sm__action_8c48f8:
	.global L_8c48f8
L_8c48f8:
	push_s blink
L_8c48fa:
	push_s r13
L_8c48fc:
	mov_s r13,r0
L_8c48fe:
	ld_s r0,[r1,0x2c]
L_8c4900:
	brne r0,0x1,L_8c491a
L_8c4904:
	bl.d L_8e2520
L_8c4908:
	mov_s r0,r13
L_8c490a:
	mov_s r0,r13
L_8c490c:
	mov_s r1,0x6
	.global L_8c490e
L_8c490e:
	mov_s r2,0x0
L_8c4910:
	mov_s r3,r2
L_8c4912:
	bl.d L_8e7044
L_8c4916:
	mov_s r4,r2
L_8c4918:
	b_s L_8c4948
	.global L_8c491a
L_8c491a:
	ld_s r0,[r13,0xc]
L_8c491c:
	breq r0,0x1,L_8c4948
L_8c4920:
	ldb_s r1,[r13,0x18]
L_8c4922:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c4924:
	extb_s r1,r1
L_8c4926:
	stb_s r1,[r13,0x18]
L_8c4928:
	ldb_s r0,[gp,0xcd]
L_8c492a:
	brne r1,r0,L_8c493a
L_8c492e:
	bl.d L_8e2520
L_8c4932:
	mov_s r0,r13
L_8c4934:
	mov_s r0,r13
L_8c4936:
	mov_s r1,0x5
L_8c4938:
	b_s L_8c490e
	.global L_8c493a
L_8c493a:
	bl.d L_8cbeb8
L_8c493e:
	ld_s r0,[r13,0x8]
L_8c4940:
	extb_s r0,r0
L_8c4942:
	bl.d L_8dc228
L_8c4946:
	mov_s r1,0x0
	.global L_8c4948
L_8c4948:
	b L_8c025c
