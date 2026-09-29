/* rx_macq__bind_all_queues @ 0x8dd124, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_macq.cpp
 * Зовут его: rx_macq__init, wmi_handler_cfg_rx_chain
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, rx_macq__bind_queue
 */
	.section .text.rx_macq__bind_all_queues,"ax",@progbits
	.global rx_macq__bind_all_queues
rx_macq__bind_all_queues:
	.global L_8dd124
L_8dd124:
	push_s blink
L_8dd126:
	bl L_8c02b8
L_8dd12a:
	mov_s r14,r0
L_8dd12c:
	ldb_s r0,[r0,0x1]
L_8dd12e:
	mov_s r16,r2
L_8dd130:
	mov_s r17,r1
L_8dd132:
	brhs.d r0,0x6,L_8dd160
L_8dd136:
	mov_s r13,0x0
L_8dd138:
	ldb.x r0,[0x802b1c,r0]
L_8dd140:
	add r1,pcl,0x8
L_8dd144:
	add1_s r1,r1,r0
L_8dd146:
	j_s [r1]
	.global L_8dd148
L_8dd148:
	mov_s r1,r13
L_8dd14a:
	b_s L_8dd152
L_8dd14c:
	mov_s r1,0x2
L_8dd14e:
	b_s L_8dd152
L_8dd150:
	mov_s r1,0x1
	.global L_8dd152
L_8dd152:
	ldb_s r0,[r14]
L_8dd154:
	mov_s r2,r17
L_8dd156:
	bl.d L_8df710
L_8dd15a:
	mov_s r3,r16
L_8dd15c:
	b L_8c031c
	.global L_8dd160
L_8dd160:
	mov_s r0,blink
L_8dd162:
	mov_s r2,0x1015b2c
L_8dd168:
	mov_s r1,0x1275
L_8dd16e:
	bl.d L_8c82c0
L_8dd172:
	mov_s r3,0x9b
L_8dd174:
	b_s L_8dd148
L_8dd176:
	nop_s
