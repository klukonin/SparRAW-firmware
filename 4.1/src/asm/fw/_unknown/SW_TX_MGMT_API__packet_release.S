/* SW_TX_MGMT_API__packet_release @ 0x8db394, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW_TX_MGMT_API::packet_release func=0x%x
 * Зовут его: SW_TX_MGMT_API__link_up_evt, SW_TX_MGMT_API__send_packet, sw_tx_mgmt__acquire_link, tx_api__tx_complete_cb
 * Зовёт сам: TX_API__free_memory, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1
 */
	.section .text.SW_TX_MGMT_API__packet_release,"ax",@progbits
	.global SW_TX_MGMT_API__packet_release
SW_TX_MGMT_API__packet_release:
	.global L_8db394
L_8db394:
	push_s blink
L_8db396:
	bl L_8c02bc
L_8db39a:
	mov_s r16,r0
L_8db39c:
	mov_s r13,r1
L_8db39e:
	mov_s r15,r2
L_8db3a0:
	mov_s r14,r3
L_8db3a2:
	mov_s r2,0x1015494
L_8db3a8:
	mov_s r0,0x7
L_8db3aa:
	bl.d L_8edfcc
L_8db3ae:
	mov_s r1,0x2
L_8db3b0:
	breq_s r14,0,L_8db3c0
L_8db3b2:
	mov.f r0,r13
L_8db3b6:
	mov.ne r0,0x1
L_8db3ba:
	asl_s r0,r0
L_8db3bc:
	jl_s.d [r14]
L_8db3be:
	mov_s r1,r15
	.global L_8db3c0
L_8db3c0:
	bl.d L_8c94c4
L_8db3c4:
	mov_s r0,r16
L_8db3c6:
	b L_8c0324
L_8db3ca:
	nop_s
