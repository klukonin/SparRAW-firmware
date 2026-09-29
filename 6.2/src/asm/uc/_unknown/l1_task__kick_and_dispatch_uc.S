/* l1_task__kick_and_dispatch_uc @ 0x927378, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_task__dispatch, l1_task__entry
 * Зовёт сам: __ld_r13_to_r13_ret, uc_field_0x24_is_zero, uc_queue__dispatch_and_commit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__kick_and_dispatch_uc
l1_task__kick_and_dispatch_uc:
	.global L_927378
L_927378:
	push_s blink
L_92737a:
	push_s r13
L_92737c:
	mov_s r1,0x1
L_92737e:
	mov_s r0,0x886d80
L_927384:
	st_s r1,[r0,0x60]
L_927386:
	sync
L_92738a:
	mov_s r1,0x1
L_92738c:
	mov_s r0,0x886d80
L_927392:
	st_s r1,[r0,0x50]
L_927394:
	sync
L_927398:
	b_s L_9273a0
	.global L_92739a
L_92739a:
	bl.d L_92fb40
L_92739e:
	mov_s r0,r13
	.global L_9273a0
L_9273a0:
	mov_s r13,0x802470
L_9273a6:
	bl.d L_920dac
L_9273aa:
	mov_s r0,r13
L_9273ac:
	brne_s r0,0,L_92739a
L_9273ae:
	mov_s r1,0x1
L_9273b0:
	mov_s r0,0x886d80
L_9273b6:
	st_s r1,[r0,0x64]
L_9273b8:
	sync
L_9273bc:
	b L_9202ac
