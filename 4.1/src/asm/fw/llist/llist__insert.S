/* llist__insert @ 0x8c1fc4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   llist.cpp
 * Зовут его: TX_API__handle_completed_packets, conn_mgr__add_to_rinking_list, find_main_sm__bcon, fwq_tx__enqueue, fwq_tx__flush_list_packets_by_cid, fwq_tx__handle_completion, fwq_tx__long_retry_failures, fwq_tx__send_next, llist_pair__insert_into_shorter, mid__add_connection
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.llist__insert,"ax",@progbits
	.global llist__insert
llist__insert:
	.global L_8c1fc4
L_8c1fc4:
	push_s blink
L_8c1fc6:
	bl L_8c02c4
L_8c1fca:
	mov.f r13,r1
L_8c1fce:
	mov_s r14,r0
L_8c1fd0:
	beq_s L_8c1fe0
	.global L_8c1fd2
L_8c1fd2:
	ld_s r0,[r13,0x4]
L_8c1fd4:
	brne_s r0,0,L_8c1ff2
	.global L_8c1fd6
L_8c1fd6:
	ld_s r0,[r14]
L_8c1fd8:
	breq_s r0,0,L_8c2004
L_8c1fda:
	ld_s r0,[r14,0x8]
L_8c1fdc:
	st_s r13,[r0]
L_8c1fde:
	b_s L_8c2006
	.global L_8c1fe0
L_8c1fe0:
	mov_s r0,blink
L_8c1fe2:
	mov_s r2,0x1001de0
L_8c1fe8:
	mov_s r1,0xd3
L_8c1fea:
	bl.d L_8c82c0
L_8c1fee:
	mov_s r3,0x28
L_8c1ff0:
	b_s L_8c1fd2
	.global L_8c1ff2
L_8c1ff2:
	mov_s r0,blink
L_8c1ff4:
	mov_s r2,0x1001de0
L_8c1ffa:
	mov_s r1,0xd4
L_8c1ffc:
	bl.d L_8c82c0
L_8c2000:
	mov_s r3,0x29
L_8c2002:
	b_s L_8c1fd6
	.global L_8c2004
L_8c2004:
	st_s r13,[r14,0x4]
	.global L_8c2006
L_8c2006:
	mov_s r0,0x0
L_8c2008:
	st_s r13,[r14,0x8]
L_8c200a:
	st_s r0,[r13]
L_8c200c:
	ld_s r0,[r14]
L_8c200e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c2010:
	st_s r0,[r14]
L_8c2012:
	b.d L_8c0334
L_8c2016:
	st_s r14,[r13,0x4]
