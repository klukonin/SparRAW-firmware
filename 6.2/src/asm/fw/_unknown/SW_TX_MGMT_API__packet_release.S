/* SW_TX_MGMT_API__packet_release @ 0x8df624, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW_TX_MGMT_API::packet_release func=0x%x
 * Зовут его: SW_TX_MGMT_API__link_up_evt, SW_TX_MGMT_API__send_packet, sw_tx_mgmt__acquire_link, sw_tx_mgmt__tx_complete_cb
 * Зовёт сам: TX_API__free_memory, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global SW_TX_MGMT_API__packet_release
SW_TX_MGMT_API__packet_release:
	.global L_8df624
L_8df624:
	push_s blink
L_8df626:
	bl L_8c01dc
L_8df62a:
	mov_s r16,r0
L_8df62c:
	mov_s r13,r1
L_8df62e:
	mov_s r15,r2
L_8df630:
	mov_s r14,r3
L_8df632:
	mov_s r1,0x1018834
L_8df638:
	mov_s r0,0x27
L_8df63a:
	bl.d L_8dcc10
L_8df63e:
	mov_s r2,r3
L_8df640:
	breq_s r14,0,L_8df650
L_8df642:
	mov.f r0,r13
L_8df646:
	mov.ne r0,0x1
L_8df64a:
	asl_s r0,r0
L_8df64c:
	jl_s.d [r14]
L_8df64e:
	mov_s r1,r15
	.global L_8df650
L_8df650:
	bl.d L_8cb10c
L_8df654:
	mov_s r0,r16
L_8df656:
	b L_8c0244
L_8df65a:
	nop_s
