/* stream_mgr__action_step @ 0x8cb288, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__action
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, conn_mgr__by_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__action_step
stream_mgr__action_step:
	.global L_8cb288
L_8cb288:
	push_s blink
L_8cb28a:
	bl.d L_8c01e0
L_8cb28e:
	mov_s r0,r3
L_8cb290:
	mov_s r15,r1
L_8cb292:
	mov_s r14,r2
L_8cb294:
	bl.d L_8cbffc
L_8cb298:
	mov_s r13,r3
L_8cb29a:
	cmp_s r0,0x0
L_8cb29c:
	add.ne r0,r0,0x164
L_8cb2a4:
	mov.ne r1,0x2
L_8cb2a8:
	mov.ne r2,r15
L_8cb2ac:
	mov.ne r3,r14
L_8cb2b0:
	bl.ne.d L_8d9b6c
L_8cb2b4:
	mov.ne r4,r13
L_8cb2b8:
	b L_8c024c
