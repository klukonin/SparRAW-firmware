/* conn_mgr__add_to_rinking_list @ 0x8c25e4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::add_to_rinking_list() ADD index CID %d to ranking list.
 *   conn_mgr.cpp
 * Зовут его: conn_mgr__activate_conn, conn_mgr__link_up_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__find_in_ranking_list, fw_log__emit1, fw_sysassert_fatal, llist__insert, mem_pool__allocate
 */
	.section .text.conn_mgr__add_to_rinking_list,"ax",@progbits
	.global conn_mgr__add_to_rinking_list
conn_mgr__add_to_rinking_list:
	.global L_8c25e4
L_8c25e4:
	push_s blink
L_8c25e6:
	bl L_8c02c0
L_8c25ea:
	bl.d L_8d725c
L_8c25ee:
	mov_s r13,r0
L_8c25f0:
	brne_s r0,0,L_8c2620
L_8c25f2:
	mov_s r15,0x80461c
L_8c25f8:
	bl.d L_8c2dc8
L_8c25fc:
	add2 r0,r15,0x1b
L_8c2600:
	mov.f r14,r0
L_8c2604:
	beq_s L_8c2624
	.global L_8c2606
L_8c2606:
	st_s r13,[r14,0x8]
L_8c2608:
	mov_s r0,r15
L_8c260a:
	bl.d L_8c1fc4
L_8c260e:
	mov_s r1,r14
L_8c2610:
	mov_s r2,0x100a948
L_8c2616:
	mov_s r0,0xb
L_8c2618:
	mov_s r1,0x2
L_8c261a:
	bl.d L_8edfcc
L_8c261e:
	ldb_s r3,[r13,0x8]
	.global L_8c2620
L_8c2620:
	b L_8c032c
	.global L_8c2624
L_8c2624:
	mov_s r0,blink
L_8c2626:
	mov_s r2,0x100a878
L_8c262c:
	mov_s r1,0x11cc
L_8c2632:
	bl.d L_8c82c0
L_8c2636:
	mov_s r3,0xe1
L_8c2638:
	b_s L_8c2606
L_8c263a:
	nop_s
