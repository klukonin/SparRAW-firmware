/* uc_wait_two_events @ 0x9316b4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow, rx_flow__run, sxd_hal__read_backoff_status, tail_uc_wait_two_events, ucode_pm__rx_off_step
 * Зовёт сам: uc_wait_event_busy
 */
	.section .text.uc_wait_two_events,"ax",@progbits
	.global uc_wait_two_events
uc_wait_two_events:
	.global L_9316b4
L_9316b4:
	st.a r13,[sp,-0x8]
L_9316b8:
	mov_s r13,r2
L_9316ba:
	asl r2,0x1,r1
L_9316c2:
	bset r2,r2,r0
L_9316c6:
	xor r0,r2,0x7f
L_9316ce:
	asl_s r0,r0,0x8
L_9316d0:
	or r1,r0,0x27000000
L_9316d8:
	ld_s r0,[gp,-0x48]
L_9316da:
	st blink,[sp, 0x4]
L_9316de:
	or_s r0,r0,r1
L_9316e0:
	mov r32,r0
L_9316e4:
	st.ab r0,[r25,0x4]
L_9316e8:
	bclr r25,r25,0xa
L_9316ec:
	mov_s r3,0x2004200
L_9316f2:
	mov_s r32,r3
L_9316f4:
	st.ab r3,[r25,0x4]
L_9316f8:
	bclr r25,r25,0xa
L_9316fc:
	nop_s
L_9316fe:
	nop_s
L_931700:
	nop_s
L_931702:
	mov_s r0,0x0
L_931704:
	bset r0,r0,0xe
L_931708:
	bl.d L_931808
L_93170c:
	mov r1,r13
L_931710:
	ld blink,[sp, 0x4]
L_931714:
	j.d [blink]
L_931718:
	ld.ab r13,[sp,0x8]
