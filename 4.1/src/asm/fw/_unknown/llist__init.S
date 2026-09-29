/* llist__init @ 0x8de5c4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__handle_completed_packets, fwq_tx__init, mid_pool__init, radio_mgr__init_list, rx_api__drain_list, tx_api__init_oob_pools, u_schd__init_queue
 */
	.section .text.llist__init,"ax",@progbits
	.global llist__init
llist__init:
	.global L_8de5c4
L_8de5c4:
	mov_s r1,0x0
L_8de5c6:
	st_s r1,[r0,0x4]
L_8de5c8:
	st_s r1,[r0,0x8]
L_8de5ca:
	j_s.d [blink]
L_8de5cc:
	st_s r1,[r0]
L_8de5ce:
	nop_s
