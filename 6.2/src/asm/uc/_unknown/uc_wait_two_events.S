/* uc_wait_two_events @ 0x936594, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow, mac__set_mode_0000, rx__enter_listen_mode, rx_flow__run, uc_wait_one_event
 * Зовёт сам: uc_wait_event_busy
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_wait_two_events
uc_wait_two_events:
	.global L_936594
L_936594:
	st.a r13,[sp,-0x8]
L_936598:
	mov_s r13,r2
L_93659a:
	asl r2,0x1,r1
L_9365a2:
	bset r2,r2,r0
L_9365a6:
	xor r0,r2,0x7f
L_9365ae:
	asl_s r0,r0,0x8
L_9365b0:
	or r1,r0,0x27000000
L_9365b8:
	ld_s r0,[gp,-0x48]
L_9365ba:
	st blink,[sp, 0x4]
L_9365be:
	or_s r0,r0,r1
L_9365c0:
	mov r32,r0
L_9365c4:
	st.ab r0,[r25,0x4]
L_9365c8:
	bclr r25,r25,0xa
L_9365cc:
	mov_s r3,0x2004200
L_9365d2:
	mov_s r32,r3
L_9365d4:
	st.ab r3,[r25,0x4]
L_9365d8:
	bclr r25,r25,0xa
L_9365dc:
	nop_s
L_9365de:
	nop_s
L_9365e0:
	nop_s
L_9365e2:
	mov_s r0,0x0
L_9365e4:
	bset r0,r0,0xe
L_9365e8:
	bl.d L_9366e8
L_9365ec:
	mov r1,r13
L_9365f0:
	ld blink,[sp, 0x4]
L_9365f4:
	j.d [blink]
L_9365f8:
	ld.ab r13,[sp,0x8]
