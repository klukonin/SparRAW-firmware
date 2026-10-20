/* rm_sm__action_8e83f4 @ 0x8e83f4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   switch_2_secondary - pop request. for CB:0x%x
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, list__find_entry_d, rm__llist_pop_front_thunk, rm__load_request_params, rm_main_sm__kick_channel_switch_sm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_sm__action_8e83f4
rm_sm__action_8e83f4:
	.global L_8e83f4
L_8e83f4:
	push_s blink
L_8e83f6:
	bl L_8c01e4
L_8e83fa:
	mov_s r13,r0
L_8e83fc:
	bl.d L_8e0bc8
L_8e8400:
	ld_s r0,[r0,0x8]
L_8e8402:
	mov_s r14,r0
L_8e8404:
	ldb_s r0,[r13,0x3]
L_8e8406:
	breq_s r0,0,L_8e8416
L_8e8408:
	mov_s r1,0x1019288
L_8e840e:
	mov_s r0,0x28
L_8e8410:
	bl.d L_8dcc10
L_8e8414:
	ld_s r2,[r14,0xc]
	.global L_8e8416
L_8e8416:
	add2 r0,r13,0x1f
L_8e841a:
	bl.d L_8c25f4
L_8e841e:
	mov_s r1,r14
L_8e8420:
	mov_s r0,0x2
L_8e8422:
	st_s r0,[r14,0x8]
L_8e8424:
	mov_s r0,r13
L_8e8426:
	bl.d L_8eaccc
L_8e842a:
	mov_s r1,r14
L_8e842c:
	bl.d L_8da6e4
L_8e8430:
	mov_s r0,r13
L_8e8432:
	b L_8c0254
L_8e8436:
	nop_s
