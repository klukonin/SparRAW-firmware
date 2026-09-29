/* l2mgr__setup_bcast_queues @ 0x8f2b38, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: rx_macq__setup_default, tx_macq__config_bcast_ring
 */
	.section .text.l2mgr__setup_bcast_queues,"ax",@progbits
	.global l2mgr__setup_bcast_queues
l2mgr__setup_bcast_queues:
	.global L_8f2b38
L_8f2b38:
	push_s blink
L_8f2b3a:
	bl L_8d68a8
L_8f2b3e:
	bl L_8d6874
L_8f2b42:
	pop_s blink
L_8f2b44:
	j_s [blink]
L_8f2b46:
	nop_s
