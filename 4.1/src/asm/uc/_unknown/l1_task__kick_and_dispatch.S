/* l1_task__kick_and_dispatch @ 0x925a08, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_task__dispatch, l1_task__entry
 * Зовёт сам: __ld_r13_ret_uc, uc_field_0x24_is_zero, uc_queue__dispatch_and_commit
 */
	.section .text.l1_task__kick_and_dispatch,"ax",@progbits
	.global l1_task__kick_and_dispatch
l1_task__kick_and_dispatch:
	.global L_925a08
L_925a08:
	push_s blink
L_925a0a:
	push_s r13
L_925a0c:
	mov_s r1,0x1
L_925a0e:
	mov_s r0,0x886d80
L_925a14:
	st_s r1,[r0,0x60]
L_925a16:
	sync
L_925a1a:
	mov_s r1,0x1
L_925a1c:
	mov_s r0,0x886d80
L_925a22:
	st_s r1,[r0,0x50]
L_925a24:
	sync
L_925a28:
	b_s L_925a30
	.global L_925a2a
L_925a2a:
	bl.d L_92bd40
L_925a2e:
	mov_s r0,r13
	.global L_925a30
L_925a30:
	mov_s r13,0x801618
L_925a36:
	bl.d L_921998
L_925a3a:
	mov_s r0,r13
L_925a3c:
	brne_s r0,0,L_925a2a
L_925a3e:
	mov_s r1,0x1
L_925a40:
	mov_s r0,0x886d80
L_925a46:
	st_s r1,[r0,0x64]
L_925a48:
	sync
L_925a4c:
	b L_92028c
