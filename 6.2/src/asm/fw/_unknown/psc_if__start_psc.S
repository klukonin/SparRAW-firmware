/* psc_if__start_psc @ 0x8d9cc8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCP psc_if::start_psc. sending Unsolicit PSC-RESP
 *   STA psc_if::start_psc. bi_start_time:0x%x, number_of_awake_bi:%d, sleep_cycle:%d
 * Зовут его: PS_CONNECTION__psc_complete_8e1794, sm_801d64__action_8e1744, sm_801d64__action_8e175c
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit3, psc__store_time64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global psc_if__start_psc
psc_if__start_psc:
	.global L_8d9cc8
L_8d9cc8:
	sub_s sp,sp,0x8
L_8d9cca:
	push_s blink
L_8d9ccc:
	bl L_8c01dc
L_8d9cd0:
	st_s r2,[sp,0x14]
L_8d9cd2:
	st_s r3,[sp,0x18]
L_8d9cd4:
	mov_s r13,r0
L_8d9cd6:
	ld_s r0,[r0,0x4c]
L_8d9cd8:
	mov_s r16,r1
L_8d9cda:
	add r14,r13,0x20
L_8d9cde:
	mov_s r15,0x0
L_8d9ce0:
	breq_s r0,0,L_8d9cf8
L_8d9ce2:
	mov_s r1,0x100273c
L_8d9ce8:
	bl.d L_8dcba8
L_8d9cec:
	mov_s r0,0x2e
L_8d9cee:
	stb r15,[r14, 0x20]
L_8d9cf2:
	mov_s r0,r13
L_8d9cf4:
	mov_s r1,0x4
L_8d9cf6:
	b_s L_8d9d1c
	.global L_8d9cf8
L_8d9cf8:
	mov_s r1,0x1002770
L_8d9cfe:
	ldw r4,[sp, 0x18]
L_8d9d02:
	mov_s r0,0x2e
L_8d9d04:
	bl.d L_8dcd00
L_8d9d08:
	ldw r3,[sp, 0x1a]
L_8d9d0c:
	stb r16,[r14, 0x20]
L_8d9d10:
	add_s r1,sp,0x14
L_8d9d12:
	bl.d L_8e7394
L_8d9d16:
	mov_s r0,r14
L_8d9d18:
	mov_s r0,r14
L_8d9d1a:
	mov_s r1,r15
	.global L_8d9d1c
L_8d9d1c:
	mov_s r2,0x0
L_8d9d1e:
	mov_s r3,r2
L_8d9d20:
	bl.d L_8d9b6c
L_8d9d24:
	mov_s r4,r2
L_8d9d26:
	mov_s r12,0xc
L_8d9d28:
	b L_8c0246
