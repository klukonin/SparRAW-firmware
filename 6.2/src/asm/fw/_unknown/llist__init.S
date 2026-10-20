/* llist__init @ 0x8e293c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__handle_completed_packets, fwq_tx__init, mid_ctx__init_pools, radio_mgr__init_list, rx_api__drain_list, tx_api__init_pools, u_schd__init_queue
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global llist__init
llist__init:
	.global L_8e293c
L_8e293c:
	mov_s r1,0x0
L_8e293e:
	st_s r1,[r0,0x4]
L_8e2940:
	st_s r1,[r0,0x8]
L_8e2942:
	j_s.d [blink]
L_8e2944:
	st_s r1,[r0]
L_8e2946:
	nop_s
