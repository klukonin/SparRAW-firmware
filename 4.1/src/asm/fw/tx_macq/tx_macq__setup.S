/* tx_macq__setup @ 0x8d63fc, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_macq.cpp
 * Зовут его: init_bcast_queue, tx_macq_api_step, tx_queue_mgr__create_queue
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_sysassert_fatal, mac_ring_enable, sw_vring__set_ba_params, tx_macq__config_queue, tx_macq__config_queue_b
 */
	.section .text.tx_macq__setup,"ax",@progbits
	.global tx_macq__setup
tx_macq__setup:
	.global L_8d63fc
L_8d63fc:
	push_s blink
L_8d63fe:
	bl L_8c02b0
L_8d6402:
	mov_s r13,r0
L_8d6404:
	mov_s r14,r1
L_8d6406:
	mov_s r19,r3
L_8d6408:
	mov_s r15,r4
L_8d640a:
	ldb_s r0,[r0,0x2]
L_8d640c:
	mov r16,r6
L_8d6410:
	mov r17,r5
L_8d6414:
	mov r18,r7
L_8d6418:
	brne r0,0x1,L_8d6462
	.global L_8d641c
L_8d641c:
	stb_s r14,[r13,0x1]
L_8d641e:
	stw 0x1f28,[r13, 0x6]
L_8d6426:
	mov_s r0,r13
L_8d6428:
	mov_s r1,0x0
L_8d642a:
	mov_s r2,r19
L_8d642c:
	mov_s r3,0xa
L_8d642e:
	bl.d L_8c60fc
L_8d6432:
	mov_s r4,r1
L_8d6434:
	bl.d L_8c29cc
L_8d6438:
	mov_s r0,r13
L_8d643a:
	mov_s r0,r13
L_8d643c:
	mov_s r1,r16
L_8d643e:
	mov_s r2,r15
L_8d6440:
	mov_s r3,r17
L_8d6442:
	bl.d L_8c3bcc
L_8d6446:
	mov r4,r18
L_8d644a:
	cmp_s r14,0x5
L_8d644c:
	cmp.ne r14,0x6
L_8d6450:
	beq_s L_8d645a
L_8d6452:
	ldb_s r0,[r13]
L_8d6454:
	bl.d L_8e50ac
L_8d6458:
	mov_s r1,0x0
	.global L_8d645a
L_8d645a:
	mov_s r0,0x2
L_8d645c:
	b.d L_8c030c
L_8d6460:
	stb_s r0,[r13,0x2]
	.global L_8d6462
L_8d6462:
	mov_s r0,blink
L_8d6464:
	mov_s r2,0x1015aa0
L_8d646a:
	mov_s r1,0x127b
L_8d6470:
	bl.d L_8c82c0
L_8d6474:
	mov_s r3,0x13
L_8d6476:
	b_s L_8d641c
