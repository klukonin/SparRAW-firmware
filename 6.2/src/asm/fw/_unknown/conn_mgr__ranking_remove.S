/* conn_mgr__ranking_remove @ 0x8ca6fc, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Removed index CID %d from ranking list.
 * Зовут его: conn_main_sm__start_disc, conn_mgr__link_up_evt
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, iter__init, iter__next, list__has_items, stream_mgr__check_vring, tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__ranking_remove
conn_mgr__ranking_remove:
	.global L_8ca6fc
L_8ca6fc:
	push_s blink
L_8ca6fe:
	bl L_8c01dc
L_8ca702:
	sub_s sp,sp,0x4
L_8ca704:
	mov_s r15,r0
L_8ca706:
	mov_s r13,sp
L_8ca708:
	mov r16,0x854000
L_8ca710:
	mov_s r0,r13
L_8ca712:
	bl.d L_8e5df4
L_8ca716:
	mov_s r1,r16
L_8ca718:
	b_s L_8ca728
	.global L_8ca71a
L_8ca71a:
	bl.d L_8df438
L_8ca71e:
	mov_s r0,r13
L_8ca720:
	mov_s r14,r0
L_8ca722:
	ld_s r0,[r0,0x8]
L_8ca724:
	breq r15,r0,L_8ca734
	.global L_8ca728
L_8ca728:
	bl.d L_8cdcb8
L_8ca72c:
	mov_s r0,r13
L_8ca72e:
	brne_s r0,0,L_8ca71a
L_8ca730:
	mov_s r0,0x0
L_8ca732:
	b_s L_8ca75a
	.global L_8ca734
L_8ca734:
	mov_s r0,r16
L_8ca736:
	bl.d L_8e2884
L_8ca73a:
	mov_s r1,r14
L_8ca73c:
	mov_s r0,0x0
L_8ca73e:
	st_s r0,[r14,0x8]
L_8ca740:
	add2 r0,r16,0x1b
L_8ca744:
	bl.d L_8caed0
L_8ca748:
	mov_s r1,r14
L_8ca74a:
	mov_s r1,0x100be68
L_8ca750:
	mov_s r0,0x2b
L_8ca752:
	bl.d L_8dcc10
L_8ca756:
	ldb_s r2,[r15,0x8]
L_8ca758:
	mov_s r0,0x1
	.global L_8ca75a
L_8ca75a:
	b.d L_8c0244
L_8ca75e:
	add_s sp,sp,0x4
