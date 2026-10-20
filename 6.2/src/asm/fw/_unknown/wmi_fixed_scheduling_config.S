/* wmi_fixed_scheduling_config @ 0x8ec56c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_fixed_scheduling_config
wmi_fixed_scheduling_config:
	.global L_8ec56c
L_8ec56c:
	push_s blink
L_8ec56e:
	bl.d L_8c01d8
L_8ec572:
	mov lp_count,0xd
L_8ec576:
	mov_s r16,r0
L_8ec578:
	mov_s r17,r2
L_8ec57a:
	add3 r13,r1,0x10
L_8ec57e:
	ldw_s r0,[r13,0x1c]
L_8ec580:
	mov_s r2,0x847abc
L_8ec586:
	stw_s r0,[r2,0x1c]
L_8ec588:
	ldw_s r0,[r13,0x1e]
L_8ec58a:
	mov_s r3,0x847a3c
L_8ec590:
	stw_s r0,[r2,0x1e]
L_8ec592:
	ldw_s r0,[r13,0x20]
L_8ec594:
	sub_s sp,sp,0x4
L_8ec596:
	stw_s r0,[r2,0x20]
L_8ec598:
	ldb r0,[r1, 0xa4]
L_8ec59c:
	stb r0,[r3, 0xa4]
L_8ec5a0:
	ldw_s r0,[r13,0x22]
L_8ec5a2:
	stw_s r0,[r2,0x22]
L_8ec5a4:
	mov_s r2,0x0
L_8ec5a6:
	lp L_8ec5d0
L_8ec5aa:
	asl_s r0,r2,0x2
L_8ec5ac:
	add1_s r0,r0,r0
L_8ec5ae:
	add_s r13,r0,r1
L_8ec5b0:
	ldb_s r15,[r13]
L_8ec5b2:
	add_s r0,r0,r1
L_8ec5b4:
	/* asl_s r15,r15,0x2 */
	.byte 0x02,0xbf
L_8ec5b6:
	add1_s r15,r15,r15
L_8ec5b8:
	add_s r14,r15,r3
L_8ec5ba:
	ldb_s r15,[r13,0x1]
L_8ec5bc:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8ec5be:
	stb_s r15,[r14]
L_8ec5c0:
	ldb_s r15,[r13,0x2]
L_8ec5c2:
	stb_s r15,[r14,0x1]
L_8ec5c4:
	ldw_s r15,[r13,0x4]
L_8ec5c6:
	stw_s r15,[r14,0x2]
L_8ec5c8:
	ldw_s r13,[r13,0x6]
L_8ec5ca:
	stw_s r13,[r14,0x4]
L_8ec5cc:
	ld_s r0,[r0,0x8]
L_8ec5ce:
	st_s r0,[r14,0x8]
	.global L_8ec5d0
L_8ec5d0:
	bl.d L_8c33d0
L_8ec5d4:
	mov_s r0,r16
L_8ec5d6:
	mov_s r1,r0
L_8ec5d8:
	mov_s r2,0x0
L_8ec5da:
	stb_s r2,[r0]
L_8ec5dc:
	st_s r2,[sp,0x0]
L_8ec5de:
	mov_s r0,r16
L_8ec5e0:
	mov_s r3,0x1a02
L_8ec5e6:
	mov r4,0x4
L_8ec5ea:
	mov r5,r17
L_8ec5ee:
	mov_s r6,r2
L_8ec5f0:
	bl.d L_8e4fc4
L_8ec5f4:
	mov_s r7,r2
L_8ec5f6:
	b.d L_8c023c
L_8ec5fa:
	add_s sp,sp,0x4
