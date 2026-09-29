/* mac__set_mode_0000 @ 0x93e0dc, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__start_rx_window, fixed_sched__run_tx_slot, rx__enter_listen_mode, rx_funcs__handle_ppdu_report, rx_funcs__rx_flow, tx_non_data_flow_fixed_scheduling, ucode_cmd_0x01_handler
 * Зовёт сам: uc_sysassert, uc_wait_two_events
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_mode_0000
mac__set_mode_0000:
	.global L_93e0dc
L_93e0dc:
	push_s blink
L_93e0de:
	ld_s r0,[gp,-0x44]
L_93e0e0:
	and r0,r0,0xffff0fff
L_93e0e8:
	st.as r0,[gp,-0x11]
L_93e0ec:
	or r0,r0,0x1d000000
L_93e0f4:
	mov_s r32,r0
L_93e0f6:
	st.ab r0,[r25,0x4]
L_93e0fa:
	bclr r25,r25,0xa
L_93e0fe:
	nop_s
L_93e100:
	nop_s
L_93e102:
	nop_s
L_93e104:
	bmsk r0,r40,0x2
L_93e108:
	brne r0,0x5,L_93e12c
L_93e10c:
	mov_s r0,0x5
L_93e10e:
	mov_s r1,r0
L_93e110:
	bl.d L_936594
L_93e114:
	mov_s r2,0xa
L_93e116:
	nop_s
L_93e118:
	nop_s
L_93e11a:
	nop_s
L_93e11c:
	mov_s r0,r42
L_93e11e:
	btst_s r0,0xe
L_93e120:
	mov.eq r0,blink
L_93e124:
	bl.eq.d L_926618
L_93e128:
	mov.eq r1,0x3f
	.global L_93e12c
L_93e12c:
	pop_s blink
L_93e12e:
	j_s [blink]
