/* bf__store_flow_status @ 0x9357cc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__txss_init_result, brp_init__flow, brp_responder_flow_enter, l1__rx_then_check_bf_abort, rx_flow__run_and_check_bf_abort, rx_funcs__rx_flow, txss_init__flow, txss_init__send_fdbk_wait_ack, txss_init__wait_rss, txss_resp__flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__store_flow_status
bf__store_flow_status:
	.global L_9357cc
L_9357cc:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9357ce:
	add2_s r0,r0,r0
L_9357d0:
	add r2,r0,0x802000
L_9357d8:
	st_s r1,[r2]
L_9357da:
	j_s [blink]
