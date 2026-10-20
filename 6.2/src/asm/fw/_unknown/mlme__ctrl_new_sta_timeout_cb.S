/* mlme__ctrl_new_sta_timeout_cb @ 0x8f2188, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ctrl_new_sta_timeout_cb
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0, mem_pool__free_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme__ctrl_new_sta_timeout_cb
mlme__ctrl_new_sta_timeout_cb:
	.global L_8f2188
L_8f2188:
	push_s blink
L_8f218a:
	bl L_8c01e4
L_8f218e:
	mov_s r13,r0
L_8f2190:
	mov_s r1,0x10113cc
L_8f2196:
	bl.d L_8dcba8
L_8f219a:
	mov_s r0,0x1a
L_8f219c:
	mov_s r14,0x0
L_8f219e:
	ld_s r0,[r13,0x2c]
L_8f21a0:
	st_s r14,[r13,0x18]
L_8f21a2:
	st_s r14,[r13,0xc]
L_8f21a4:
	breq_s r0,0,L_8f21ac
L_8f21a6:
	bl L_8cb15c
L_8f21aa:
	st_s r14,[r13,0x2c]
	.global L_8f21ac
L_8f21ac:
	mov_s r0,r13
L_8f21ae:
	mov_s r1,0x5
L_8f21b0:
	mov_s r2,0x0
L_8f21b2:
	mov_s r3,r2
L_8f21b4:
	bl.d L_8d9b6c
L_8f21b8:
	mov_s r4,r2
L_8f21ba:
	b L_8c0254
L_8f21be:
	nop_s
