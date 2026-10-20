/* install_key_index_stub @ 0x8e9440, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TODO !!!! install_key ... Need to support key index
 * Зовут его: disconn_sm__on_ntf_fw_tx_stopped, l2mgr__install_key, l2mgr__send_keys_to_ucode
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, lmac_mbox__alloc_slot, memcpy_fw, send_cmd2_lmac
 */
	.section .text.install_key_index_stub,"ax",@progbits
	.global install_key_index_stub
install_key_index_stub:
	.global L_8e9440
L_8e9440:
	push_s blink
L_8e9442:
	bl L_8c02b8
L_8e9446:
	mov_s r14,r0
L_8e9448:
	mov_s r15,r1
L_8e944a:
	mov_s r17,r2
L_8e944c:
	bl.d L_8c2b0c
L_8e9450:
	mov r16,r4
L_8e9454:
	mov_s r13,r0
L_8e9456:
	st_s r15,[r0,0x4]
L_8e9458:
	mov_s r0,0x80345c
L_8e945e:
	ld_s r0,[r0,0xc]
L_8e9460:
	breq_s r0,0,L_8e9470
L_8e9462:
	cmp r16,0x0
L_8e9466:
	mov_s r0,0x8
L_8e9468:
	mov.eq r0,r14
L_8e946c:
	st_s r0,[r13]
L_8e946e:
	b_s L_8e9472
	.global L_8e9470
L_8e9470:
	st_s r14,[r13]
	.global L_8e9472
L_8e9472:
	mov_s r2,0x100d684
L_8e9478:
	mov_s r0,0x0
L_8e947a:
	bl.d L_8edfb0
L_8e947e:
	mov_s r1,0x2
L_8e9480:
	mov_s r0,0x34
L_8e9482:
	st_s r0,[r13,0x8]
L_8e9484:
	mov_s r2,0x10
L_8e9486:
	st_s r2,[r13,0xc]
L_8e9488:
	add r0,r13,0x10
L_8e948c:
	bl.d L_8c0460
L_8e9490:
	mov_s r1,r17
L_8e9492:
	mov_s r0,r13
L_8e9494:
	mov_s r1,0x18
L_8e9496:
	mov_s r2,0x20
L_8e9498:
	bl.d L_8e0694
L_8e949c:
	mov_s r3,0x0
L_8e949e:
	b L_8c031c
L_8e94a2:
	nop_s
