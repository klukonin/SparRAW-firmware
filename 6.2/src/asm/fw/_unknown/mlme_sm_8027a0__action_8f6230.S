/* mlme_sm_8027a0__action_8f6230 @ 0x8f6230, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lms_stopped() DISC SM - spurious LMS Stop Done notification.
 * Зовёт сам: basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_8027a0__action_8f6230
mlme_sm_8027a0__action_8f6230:
	.global L_8f6230
L_8f6230:
	push_s blink
L_8f6232:
	mov_s r3,r0
L_8f6234:
	ld_s r0,[r0,0xc]
L_8f6236:
	bbit0 r0,0x2,L_8f625e
L_8f623a:
	bic r0,r0,0xc
L_8f623e:
	bset_s r0,r0,0x3
L_8f6240:
	st_s r0,[r3,0xc]
L_8f6242:
	ld_s r0,[r3,0x8]
L_8f6244:
	mov r4,0x323f8
L_8f624c:
	ld_s r0,[r0,0x8]
L_8f624e:
	mov_s r1,0x1
L_8f6250:
	add r0,r0,0xf0
L_8f6254:
	mov_s r2,0x0
L_8f6256:
	bl.d L_8d9b6c
L_8f625a:
	ldw_s r3,[r3,0x16]
L_8f625c:
	b_s L_8f626a
	.global L_8f625e
L_8f625e:
	mov_s r1,0x1011da8
L_8f6264:
	bl.d L_8dcba8
L_8f6268:
	mov_s r0,0x2b
	.global L_8f626a
L_8f626a:
	pop_s blink
L_8f626c:
	j_s [blink]
L_8f626e:
	nop_s
