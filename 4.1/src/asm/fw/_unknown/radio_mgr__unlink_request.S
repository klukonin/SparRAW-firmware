/* radio_mgr__unlink_request @ 0x8de424, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_mgr__alloc_request
 * Зовёт сам: llist__remove
 */
	.section .text.radio_mgr__unlink_request,"ax",@progbits
	.global radio_mgr__unlink_request
radio_mgr__unlink_request:
	.global L_8de424
L_8de424:
	push_s blink
L_8de426:
	ld_s r2,[r1,0x4]
L_8de428:
	cmp_s r0,r2
L_8de42a:
	mov_s r2,0x1
L_8de42c:
	sub_s.ne r2,r2,r2
L_8de42e:
	extb.f 0x0,r2
L_8de432:
	mov.eq r0,0x0
L_8de436:
	beq_s L_8de43e
L_8de438:
	bl L_8de4ec
L_8de43c:
	mov_s r0,0x1
	.global L_8de43e
L_8de43e:
	pop_s blink
L_8de440:
	j_s [blink]
L_8de442:
	nop_s
