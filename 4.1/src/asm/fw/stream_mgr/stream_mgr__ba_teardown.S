/* stream_mgr__ba_teardown @ 0x8c76bc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr.cpp
 * Зовёт сам: TX_API__free_memory, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, stream_mgr__find_vring_by_cid, ul_stream__ba_sm_evt
 */
	.section .text.stream_mgr__ba_teardown,"ax",@progbits
	.global stream_mgr__ba_teardown
stream_mgr__ba_teardown:
L_8c76bc:
	push_s blink
L_8c76be:
	bl L_8c02c0
L_8c76c2:
	mov_s r13,r0
L_8c76c4:
	ldb_s r0,[r0,0x1b]
L_8c76c6:
	mov_s r15,r1
L_8c76c8:
	lsr_s r0,r0,0x4
L_8c76ca:
	bl.d L_8cab10
L_8c76ce:
	ldb_s r1,[r2,0x8]
L_8c76d0:
	mov.f r14,r0
L_8c76d4:
	beq_s L_8c76f2
	.global L_8c76d6
L_8c76d6:
	cmp_s r15,0x0
L_8c76d8:
	mov_s r2,0x1
L_8c76da:
	sub_s.ne r2,r2,r2
L_8c76dc:
	mov_s r0,r14
L_8c76de:
	mov_s r1,0x2
L_8c76e0:
	mov_s r3,0x0
L_8c76e2:
	bl.d L_8d6afc
L_8c76e6:
	mov_s r4,r3
L_8c76e8:
	bl.d L_8c94c4
L_8c76ec:
	mov_s r0,r13
L_8c76ee:
	b L_8c032c
	.global L_8c76f2
L_8c76f2:
	mov_s r0,blink
L_8c76f4:
	mov_s r2,0x100e398
L_8c76fa:
	mov_s r1,0x1292
L_8c7700:
	bl.d L_8c82c0
L_8c7704:
	mov r3,0x189
