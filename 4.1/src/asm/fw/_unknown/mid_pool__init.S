/* mid_pool__init @ 0x8d61a4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, llist__init, mem_pool__init, mid_ctx_pool__init
 */
	.section .text.mid_pool__init,"ax",@progbits
	.global mid_pool__init
mid_pool__init:
	.global L_8d61a4
L_8d61a4:
	push_s blink
L_8d61a6:
	bl L_8c02c4
L_8d61aa:
	bl.d L_8ed514
L_8d61ae:
	mov_s r14,0x1
L_8d61b0:
	mov_s r13,0x8058d0
L_8d61b6:
	mov_s r1,0x8058f0
L_8d61bc:
	add r0,r13,0xc
L_8d61c0:
	mov r2,0x2e4
L_8d61c4:
	bl.d L_8c6c70
L_8d61c8:
	mov_s r3,r14
L_8d61ca:
	bl.d L_8de5c4
L_8d61ce:
	mov_s r0,r13
L_8d61d0:
	mov_s r1,0x0
L_8d61d2:
	stb r1,[gp, 0xd2]
L_8d61d6:
	mov_s r0,0x857280
L_8d61dc:
	st_s r1,[r0,0x18]
L_8d61de:
	st 0x2710,[r0, 0x1c]
L_8d61e6:
	st_s r14,[r0,0x20]
L_8d61e8:
	b.d L_8c0334
L_8d61ec:
	st_s r1,[r0,0x24]
L_8d61ee:
	nop_s
