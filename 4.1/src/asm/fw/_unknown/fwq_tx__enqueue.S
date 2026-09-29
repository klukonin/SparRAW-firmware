/* fwq_tx__enqueue @ 0x8c2460, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__awake_peer_ntf, TX_API__send_dband_bcon, TX_API__send_packet, fwq_tx__long_retry_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fwq_tx__check_prio, fwq_tx__send_next, llist__insert
 */
	.section .text.fwq_tx__enqueue,"ax",@progbits
	.global fwq_tx__enqueue
fwq_tx__enqueue:
	.global L_8c2460
L_8c2460:
	push_s blink
L_8c2462:
	bl L_8c02c0
L_8c2466:
	mov_s r14,r0
L_8c2468:
	mov_s r15,r1
L_8c246a:
	mov_s r13,r2
L_8c246c:
	bl.d L_8c9b10
L_8c2470:
	mov_s r1,r2
L_8c2472:
	bl.d L_8c1fc4
L_8c2476:
	mov_s r1,r15
L_8c2478:
	ld_s r1,[r14]
L_8c247a:
	ld_s r0,[r1]
L_8c247c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c247e:
	st_s r0,[r1]
L_8c2480:
	ld_s r0,[r14,0xc]
L_8c2482:
	brne r13,r0,L_8c2492
L_8c2486:
	ld_s r0,[r14,0x8]
L_8c2488:
	cmp_s r0,0x1
L_8c248a:
	bl.eq.d L_8e0a28
L_8c248e:
	mov.eq r0,r14
	.global L_8c2492
L_8c2492:
	b L_8c032c
L_8c2496:
	nop_s
