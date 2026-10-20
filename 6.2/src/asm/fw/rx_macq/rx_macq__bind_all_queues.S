/* rx_macq__bind_all_queues @ 0x8e1298, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__init, wmi_cfg_rx_chain
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, rx_macq__bind_queue
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__bind_all_queues
rx_macq__bind_all_queues:
	.global L_8e1298
L_8e1298:
	push_s blink
L_8e129a:
	bl L_8c01d8
L_8e129e:
	mov_s r13,r0
L_8e12a0:
	ldb_s r0,[r0,0x1]
L_8e12a2:
	mov_s r16,r2
L_8e12a4:
	mov_s r17,r1
L_8e12a6:
	brhs.d r0,0x6,L_8e12d4
L_8e12aa:
	mov_s r14,0x0
L_8e12ac:
	ldb.x r0,[0x803208,r0]
L_8e12b4:
	add r1,pcl,0x8
L_8e12b8:
	add1_s r1,r1,r0
L_8e12ba:
	j_s [r1]
	.global L_8e12bc
L_8e12bc:
	mov_s r1,r14
L_8e12be:
	b_s L_8e12c6
L_8e12c0:
	mov_s r1,0x2
L_8e12c2:
	b_s L_8e12c6
L_8e12c4:
	mov_s r1,0x1
	.global L_8e12c6
L_8e12c6:
	ldb_s r0,[r13]
L_8e12c8:
	mov_s r2,r17
L_8e12ca:
	bl.d L_8e42b8
L_8e12ce:
	mov_s r3,r16
L_8e12d0:
	b L_8c023c
	.global L_8e12d4
L_8e12d4:
	mov_s r0,blink
L_8e12d6:
	mov_s r1,0x1275
L_8e12dc:
	bl L_8c9b28
L_8e12e0:
	b_s L_8e12bc
L_8e12e2:
	nop_s
