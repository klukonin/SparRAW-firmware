/* lmac_if_send_cmd_0x0c @ 0x8d83ec, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_main_sm__on_linkup_req__lm_state_idle, lmac_if__lmac_ready_evt, tail_lmac_if_send_cmd_0x0c
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bcon_ss__call_vmethod_10, bcon_ss__call_vmethod_14, lmac_mbox__alloc_slot, popcount32, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x0c,"ax",@progbits
	.global lmac_if_send_cmd_0x0c
lmac_if_send_cmd_0x0c:
	.global L_8d83ec
L_8d83ec:
	push_s blink
L_8d83ee:
	bl L_8c02b8
L_8d83f2:
	mov_s r16,r0
L_8d83f4:
	mov_s r17,r1
L_8d83f6:
	bl.d L_8c2b0c
L_8d83fa:
	mov_s r15,r2
L_8d83fc:
	mov_s r14,r0
L_8d83fe:
	mov_s r13,0x0
L_8d8400:
	st_s r13,[r0,0x10]
L_8d8402:
	st_s r13,[r0,0x14]
L_8d8404:
	st_s r13,[r0,0x18]
L_8d8406:
	mov_s r0,0x1
L_8d8408:
	stb_s r0,[r14,0x1c]
L_8d840a:
	stw r16,[r14, 0x2]
L_8d840e:
	brne r16,0x0,L_8d843c
L_8d8412:
	stb r17,[r14]
L_8d8416:
	mov_s r15,0x803e84
L_8d841c:
	mov_s r0,r15
L_8d841e:
	bl.d L_8ca8dc
L_8d8422:
	mov_s r1,r13
L_8d8424:
	st_s r0,[r14,0x4]
L_8d8426:
	mov_s r0,r15
L_8d8428:
	bl.d L_8ca8ac
L_8d842c:
	mov_s r1,r13
L_8d842e:
	st_s r0,[r14,0x8]
L_8d8430:
	mov_s r0,0x800b2c
L_8d8436:
	ld_s r0,[r0,0x8]
L_8d8438:
	st_s r0,[r14,0xc]
L_8d843a:
	b_s L_8d8472
	.global L_8d843c
L_8d843c:
	stb_s r15,[r14,0x1]
L_8d843e:
	st_s r13,[r14,0x8]
L_8d8440:
	st_s r13,[r14,0x4]
L_8d8442:
	st_s r13,[r14,0xc]
L_8d8444:
	breq_s r15,0,L_8d846c
L_8d8446:
	breq r15,0x1,L_8d8466
L_8d844a:
	breq r15,0x2,L_8d845e
L_8d844e:
	brne r15,0x3,L_8d8472
L_8d8452:
	mov_s r13,0xff
L_8d8454:
	asl_s r13,r13,0x12
L_8d8456:
	st 0x3fc0000,[r14, 0x8]
	.global L_8d845e
L_8d845e:
	mov_s r0,0x7
L_8d8460:
	st_s r0,[r14,0x4]
L_8d8462:
	bset_s r13,r13,0x1a
L_8d8464:
	st_s r13,[r14,0x8]
	.global L_8d8466
L_8d8466:
	bset_s r13,r13,0x1b
L_8d8468:
	bset_s r13,r13,0x1c
L_8d846a:
	st_s r13,[r14,0x8]
	.global L_8d846c
L_8d846c:
	bset_s r13,r13,0x1d
L_8d846e:
	bset_s r13,r13,0x1e
L_8d8470:
	st_s r13,[r14,0x8]
	.global L_8d8472
L_8d8472:
	bl.d L_8c6c5c
L_8d8476:
	ld_s r0,[r14,0x4]
L_8d8478:
	mov_s r3,r0
L_8d847a:
	bl.d L_8c6c5c
L_8d847e:
	ld_s r0,[r14,0x8]
L_8d8480:
	mov_s r1,0xc
L_8d8482:
	add_s r0,r0,r3
L_8d8484:
	stb_s r0,[r14,0x1d]
L_8d8486:
	stw_s r0,[r14,0x1e]
L_8d8488:
	mov_s r0,r14
L_8d848a:
	mov_s r2,0x20
L_8d848c:
	bl.d L_8e0694
L_8d8490:
	mov_s r3,0x0
L_8d8492:
	b L_8c031c
L_8d8496:
	nop_s
