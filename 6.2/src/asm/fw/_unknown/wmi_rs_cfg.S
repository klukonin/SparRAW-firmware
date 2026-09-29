/* wmi_rs_cfg @ 0x8dd528, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CID = %d
 *   RS ENABLE = %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, conn_mgr__by_cid, fw_log_emit1, lmac_if_send_cmd_0x13, mem_pool__alloc_locked, memset0_words, rs_cfg__validate, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_rs_cfg
wmi_rs_cfg:
	.global L_8dd528
L_8dd528:
	push_s blink
L_8dd52a:
	bl L_8c01d8
L_8dd52e:
	sub_s sp,sp,0x4
L_8dd530:
	mov_s r16,r0
L_8dd532:
	mov_s r13,r1
L_8dd534:
	mov_s r17,r2
L_8dd536:
	mov_s r1,0x100622c
L_8dd53c:
	mov_s r0,0x25
L_8dd53e:
	bl.d L_8dcc10
L_8dd542:
	ldb_s r2,[r13]
L_8dd544:
	mov_s r1,0x10066f4
L_8dd54a:
	mov_s r0,0x25
L_8dd54c:
	bl.d L_8dcc10
L_8dd550:
	ldb_s r2,[r13,0x1]
L_8dd552:
	mov_s r0,r16
L_8dd554:
	bl.d L_8dd5ac
L_8dd558:
	mov_s r1,r13
L_8dd55a:
	mov_s r15,0x1
L_8dd55c:
	brne r0,0x1,L_8dd574
L_8dd560:
	bl.d L_8cbffc
L_8dd564:
	ldb_s r0,[r13]
L_8dd566:
	breq_s r0,0,L_8dd574
L_8dd568:
	ldb_s r0,[r13]
L_8dd56a:
	add_s r2,r13,0x2
L_8dd56c:
	bl.d L_8dbbb4
L_8dd570:
	ldb_s r1,[r13,0x1]
L_8dd572:
	mov_s r15,0x0
	.global L_8dd574
L_8dd574:
	bl.d L_8c33d0
L_8dd578:
	mov_s r0,r16
L_8dd57a:
	mov_s r14,r0
L_8dd57c:
	bl.d L_8c1cd8
L_8dd580:
	mov_s r1,0x4
L_8dd582:
	stb_s r15,[r14,0x1]
L_8dd584:
	ldb_s r0,[r13]
L_8dd586:
	mov_s r2,0x0
L_8dd588:
	stb_s r0,[r14]
L_8dd58a:
	st_s r2,[sp,0x0]
L_8dd58c:
	mov_s r0,r16
L_8dd58e:
	mov_s r1,r14
L_8dd590:
	mov_s r3,0x1921
L_8dd596:
	mov r4,0x4
L_8dd59a:
	mov r5,r17
L_8dd59e:
	mov_s r6,r2
L_8dd5a0:
	bl.d L_8e4fc4
L_8dd5a4:
	mov_s r7,r2
L_8dd5a6:
	b.d L_8c023c
L_8dd5aa:
	add_s sp,sp,0x4
