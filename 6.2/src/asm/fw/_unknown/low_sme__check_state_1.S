/* low_sme__check_state_1 @ 0x8cb0b4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mailbox free_mem
 * Зовут его: low_sme__send_evt2_body
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_sysassert_fatal, stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global low_sme__check_state_1
low_sme__check_state_1:
	.global L_8cb0b4
L_8cb0b4:
	push_s blink
L_8cb0b6:
	bl L_8c01e4
L_8cb0ba:
	mov_s r14,r0
L_8cb0bc:
	ld_s r0,[r0,0x14]
L_8cb0be:
	mov_s r13,r1
L_8cb0c0:
	brne r0,0x1,L_8cb108
L_8cb0c4:
	breq_s r2,0,L_8cb0de
L_8cb0c6:
	ld_s r0,[r14,0x18]
L_8cb0c8:
	breq_s r0,0,L_8cb0ce
	.global L_8cb0ca
L_8cb0ca:
	ld_s r1,[r14,0x18]
L_8cb0cc:
	b_s L_8cb0d8
	.global L_8cb0ce
L_8cb0ce:
	mov_s r0,blink
L_8cb0d0:
	bl.d L_8c9b28
L_8cb0d4:
	mov_s r1,0xcd
L_8cb0d6:
	b_s L_8cb0ca
	.global L_8cb0d8
L_8cb0d8:
	jl_s.d [r1]
L_8cb0da:
	mov_s r0,r13
L_8cb0dc:
	b_s L_8cb108
	.global L_8cb0de
L_8cb0de:
	breq_s r3,0,L_8cb0f2
L_8cb0e0:
	ld_s r0,[r14,0x1c]
L_8cb0e2:
	breq_s r0,0,L_8cb0e8
	.global L_8cb0e4
L_8cb0e4:
	ld_s r1,[r14,0x1c]
L_8cb0e6:
	b_s L_8cb0d8
	.global L_8cb0e8
L_8cb0e8:
	mov_s r0,blink
L_8cb0ea:
	bl.d L_8c9b28
L_8cb0ee:
	mov_s r1,0xce
L_8cb0f0:
	b_s L_8cb0e4
	.global L_8cb0f2
L_8cb0f2:
	sub_s r13,r13,0x10
L_8cb0f4:
	mov_s r1,0x1001b7c
L_8cb0fa:
	bl.d L_8dcba8
L_8cb0fe:
	mov_s r0,0x0
L_8cb100:
	ld_s r0,[r14,0x10]
L_8cb102:
	bl.d L_8caed0
L_8cb106:
	mov_s r1,r13
	.global L_8cb108
L_8cb108:
	b L_8c0254
