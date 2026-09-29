/* uc_mailbox__dispatch_one @ 0x92a2b0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret_uc, uc_mailbox__next_slot, umac_if_cmd_handler
 */
	.section .text.uc_mailbox__dispatch_one,"ax",@progbits
	.global uc_mailbox__dispatch_one
uc_mailbox__dispatch_one:
L_92a2b0:
	push_s blink
L_92a2b2:
	push_s r13
L_92a2b4:
	mov_s r13,r0
L_92a2b6:
	add r2,r1,0x10
L_92a2ba:
	mov_s r0,r1
L_92a2bc:
	bl.d L_936dd0
L_92a2c0:
	mov_s r1,r2
L_92a2c2:
	add r0,r13,0x24
L_92a2c6:
	mov_s r2,0x0
L_92a2c8:
	ld_s r1,[r0]
L_92a2ca:
	bl.d L_927e6c
L_92a2ce:
	st_s r2,[r1]
L_92a2d0:
	b L_92028c
