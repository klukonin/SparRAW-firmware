/* uc_sysassert__scan_stack @ 0x92635c, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stack dump %08x-%08x:
 *     %08x: %08x
 * Зовут его: l2_handle_watchdog, uc_vector_02
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_sysassert__scan_stack
uc_sysassert__scan_stack:
	.global L_92635c
L_92635c:
	push_s blink
L_92635e:
	bl L_920234
L_926362:
	mov_s r0,0x886f00
L_926368:
	ld_s r13,[r0,0x4c]
L_92636a:
	mov_s r14,0x944000
L_926370:
	add_s r13,r13,0x130000
L_926376:
	add_s r13,r13,0x10000
L_92637c:
	mov_s r1,0x1000610
L_926382:
	mov_s r0,0x20
L_926384:
	mov_s r2,r13
L_926386:
	bl.d L_92d27c
L_92638a:
	mov_s r3,r14
L_92638c:
	b_s L_9263ae
	.global L_92638e
L_92638e:
	ld_s r3,[r13]
L_926390:
	cmp r3,0x160
L_926394:
	blo_s L_9263ac
L_926396:
	brlo 0x20000,r3,L_9263ac
L_92639e:
	mov_s r1,0x1000628
L_9263a4:
	mov_s r0,0x20
L_9263a6:
	bl.d L_92d27c
L_9263aa:
	mov_s r2,r13
	.global L_9263ac
L_9263ac:
	/* add_s r13,0x4 */
	.byte 0x04,0xe5
	.global L_9263ae
L_9263ae:
	brlo r13,r14,L_92638e
L_9263b2:
	b L_9202a4
L_9263b6:
	nop_s
