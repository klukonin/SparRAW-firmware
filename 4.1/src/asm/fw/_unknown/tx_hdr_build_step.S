/* tx_hdr_build_step @ 0x8ec4f4, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_data_builder__log_addrs
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bf_h_s0_w2, bf_h_s0_w4, bf_h_s2_w2, bf_h_s4_w4, bf_h_s5_w2, memcpy_fw
 */
	.section .text.tx_hdr_build_step,"ax",@progbits
	.global tx_hdr_build_step
tx_hdr_build_step:
	.global L_8ec4f4
L_8ec4f4:
	push_s blink
L_8ec4f6:
	bl.d L_8c02b4
L_8ec4fa:
	mov_s r7,r1
L_8ec4fc:
	mov_s r14,r0
L_8ec4fe:
	mov_s r18,r2
L_8ec500:
	mov_s r17,r3
L_8ec502:
	mov_s r13,0x0
L_8ec504:
	mov_s r1,r13
L_8ec506:
	bl.d L_8e82a0
L_8ec50a:
	mov r16,r6
L_8ec50e:
	bmsk r1,r7,0x3
L_8ec512:
	bl.d L_8e82dc
L_8ec516:
	mov_s r2,r5
L_8ec518:
	mov_s r1,0x2
L_8ec51a:
	bl.d L_8e82c4
L_8ec51e:
	mov_s r15,r4
L_8ec520:
	stw_s r13,[r14,0x2]
L_8ec522:
	ldw_s r0,[r14]
L_8ec524:
	brne r2,0x1,L_8ec54a
L_8ec528:
	bset_s r0,r0,0x8
L_8ec52a:
	stw_s r0,[r14]
L_8ec52c:
	add_s r0,r14,0x4
L_8ec52e:
	mov_s r1,r15
L_8ec530:
	bl.d L_8c0460
L_8ec534:
	mov_s r2,0x6
L_8ec536:
	add r0,r14,0xa
L_8ec53a:
	mov_s r1,r17
L_8ec53c:
	bl.d L_8c0460
L_8ec540:
	mov_s r2,0x6
L_8ec542:
	add r0,r14,0x10
L_8ec546:
	mov_s r1,r18
L_8ec548:
	b_s L_8ec56a
	.global L_8ec54a
L_8ec54a:
	bset_s r0,r0,0x9
L_8ec54c:
	stw_s r0,[r14]
L_8ec54e:
	add_s r0,r14,0x4
L_8ec550:
	mov_s r1,r18
L_8ec552:
	bl.d L_8c0460
L_8ec556:
	mov_s r2,0x6
L_8ec558:
	add r0,r14,0xa
L_8ec55c:
	mov_s r1,r15
L_8ec55e:
	bl.d L_8c0460
L_8ec562:
	mov_s r2,0x6
L_8ec564:
	add r0,r14,0x10
L_8ec568:
	mov_s r1,r17
	.global L_8ec56a
L_8ec56a:
	bl.d L_8c0460
L_8ec56e:
	mov_s r2,0x6
L_8ec570:
	stw_s r13,[r14,0x16]
L_8ec572:
	add r0,r14,0x18
L_8ec576:
	mov_s r1,0x0
L_8ec578:
	bl.d L_8e82f4
L_8ec57c:
	stw_s r13,[r14,0x18]
L_8ec57e:
	ldw_s r1,[r14,0x18]
L_8ec580:
	bclr_s r1,r1,0x7
L_8ec582:
	bclr_s r1,r1,0x4
L_8ec584:
	bclr_s r1,r1,0x9
L_8ec586:
	stw_s r1,[r14,0x18]
L_8ec588:
	bmsk r1,r16,0x3
L_8ec58c:
	bl L_8e82b8
L_8ec590:
	b.d L_8c0314
L_8ec594:
	mov_s r0,0x1a
L_8ec596:
	nop_s
