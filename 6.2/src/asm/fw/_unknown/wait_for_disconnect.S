/* wait_for_disconnect @ 0x8fb3c8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wait_for_disconnect()- disassoc wasn't sent, continue to flush_connection()
 *   wait_for_disconnect()- disassoc frame was sent, wait for callback
 *   wait_for_disconnect()- callback already set, wait for callback
 * Зовут его: mlme_sm_8027a0__action_8f24d8
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wait_for_disconnect
wait_for_disconnect:
	.global L_8fb3c8
L_8fb3c8:
	push_s blink
L_8fb3ca:
	push_s r13
L_8fb3cc:
	mov_s r13,r0
L_8fb3ce:
	ld_s r0,[r0,0x18]
L_8fb3d0:
	brne_s r0,0,L_8fb3ee
L_8fb3d2:
	mov_s r1,0x1011cd8
L_8fb3d8:
	bl.d L_8dcba8
L_8fb3dc:
	mov_s r0,0x2b
L_8fb3de:
	mov_s r0,r13
L_8fb3e0:
	mov_s r1,0x6
L_8fb3e2:
	mov_s r2,0x0
L_8fb3e4:
	mov_s r3,r2
L_8fb3e6:
	bl.d L_8d9b6c
L_8fb3ea:
	mov_s r4,r2
L_8fb3ec:
	b_s L_8fb42a
	.global L_8fb3ee
L_8fb3ee:
	ld_s r0,[r13,0x1c]
L_8fb3f0:
	brne_s r0,0,L_8fb41e
L_8fb3f2:
	mov_s r1,0x1011d24
L_8fb3f8:
	bl.d L_8dcba8
L_8fb3fc:
	mov_s r0,0x2b
L_8fb3fe:
	mov_s r0,0x3251c
L_8fb404:
	mov_s r1,r13
L_8fb406:
	mov_s r2,0x0
L_8fb408:
	mov_s r3,0x2
L_8fb40a:
	mov r4,0xf4240
L_8fb412:
	mov_s r5,r2
L_8fb414:
	bl.d L_8e0c0c
L_8fb418:
	mov_s r6,r2
L_8fb41a:
	st_s r0,[r13,0x1c]
L_8fb41c:
	b_s L_8fb42a
	.global L_8fb41e
L_8fb41e:
	mov_s r1,0x1011d68
L_8fb424:
	bl.d L_8dcba8
L_8fb428:
	mov_s r0,0x2b
	.global L_8fb42a
L_8fb42a:
	b L_8c025c
L_8fb42e:
	nop_s
