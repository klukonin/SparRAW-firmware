/* sxd_hal__read_backoff_status @ 0x9377bc, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sxd_hal_optimized_size.c
 * Зовут его: bi_manager_rx_step, bi_tx_initiator_wrap, rx_funcs__handle_ppdu_report, rx_funcs__rx_flow, shallow_sleep_rfc_step, ucode_cmd__rx_on, ucode_pm__rx_off_step
 * Зовёт сам: uc_sysassert, uc_wait_two_events
 */
	.section .text.sxd_hal__read_backoff_status,"ax",@progbits
	.global sxd_hal__read_backoff_status
sxd_hal__read_backoff_status:
	.global L_9377bc
L_9377bc:
	push_s blink
L_9377be:
	ld_s r0,[gp,-0x44]
L_9377c0:
	and r0,r0,0xffff0fff
L_9377c8:
	st.as r0,[gp,-0x11]
L_9377cc:
	or r0,r0,0x1d000000
L_9377d4:
	mov_s r32,r0
L_9377d6:
	st.ab r0,[r25,0x4]
L_9377da:
	bclr r25,r25,0xa
L_9377de:
	nop_s
L_9377e0:
	nop_s
L_9377e2:
	nop_s
L_9377e4:
	bmsk r0,r40,0x2
L_9377e8:
	brne r0,0x5,L_937814
L_9377ec:
	mov_s r0,0x5
L_9377ee:
	mov_s r1,r0
L_9377f0:
	bl.d L_9316b4
L_9377f4:
	mov_s r2,0xa
L_9377f6:
	nop_s
L_9377f8:
	nop_s
L_9377fa:
	nop_s
L_9377fc:
	mov_s r0,r42
L_9377fe:
	bbit1 r0,0xe,L_937814
L_937802:
	mov_s r0,blink
L_937804:
	mov_s r2,0x10014cc
L_93780a:
	mov_s r1,0x3f
L_93780c:
	bl.d L_925548
L_937810:
	mov r3,0x125
	.global L_937814
L_937814:
	pop_s blink
L_937816:
	j_s [blink]
