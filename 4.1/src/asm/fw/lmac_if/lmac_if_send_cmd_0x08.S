/* lmac_if_send_cmd_0x08 @ 0x8d8864, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__reset_queue_0x19, dma_mgr__reset_queue_0x1a, frag_8e4740, sm_pring__timeout, vring__wait_macq_delete, vring_schd__add_vring
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x08,"ax",@progbits
	.global lmac_if_send_cmd_0x08
lmac_if_send_cmd_0x08:
	.global L_8d8864
L_8d8864:
	push_s blink
L_8d8866:
	bl L_8c02b0
L_8d886a:
	mov_s r14,r0
L_8d886c:
	mov_s r13,r1
L_8d886e:
	mov_s r15,r2
L_8d8870:
	mov_s r16,r3
L_8d8872:
	mov r17,r4
L_8d8876:
	mov r18,r5
L_8d887a:
	bl.d L_8c2b0c
L_8d887e:
	mov r19,r6
L_8d8882:
	stb r16,[r0]
L_8d8886:
	stb_s r15,[r0,0x1]
L_8d8888:
	st_s r14,[r0,0x4]
L_8d888a:
	st_s r13,[r0,0x8]
L_8d888c:
	mov_s r1,0x0
L_8d888e:
	stb_s r1,[r0,0x10]
L_8d8890:
	bmsk r1,r17,0x0
L_8d8894:
	asl_s r2,r1,0x6
L_8d8896:
	bmsk r1,r18,0x0
L_8d889a:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8d889c:
	or_s r1,r1,r2
L_8d889e:
	st_s r1,[r0,0xc]
L_8d88a0:
	breq r19,0x0,L_8d88aa
L_8d88a4:
	ld_s r1,[r0,0x10]
L_8d88a6:
	bset_s r1,r1,0x1
L_8d88a8:
	st_s r1,[r0,0x10]
	.global L_8d88aa
L_8d88aa:
	mov_s r1,0x8
L_8d88ac:
	mov_s r2,0x14
L_8d88ae:
	bl.d L_8e0694
L_8d88b2:
	mov_s r3,0x0
L_8d88b4:
	b L_8c030c
