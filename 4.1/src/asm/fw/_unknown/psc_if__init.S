/* psc_if__init @ 0x8d632c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   psc_if::init
 * Зовут его: PS_CONNECTION__assoc_ntf
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, pcp_psc_sm__init, sta_psc_sm__init
 */
	.section .text.psc_if__init,"ax",@progbits
	.global psc_if__init
psc_if__init:
	.global L_8d632c
L_8d632c:
	push_s blink
L_8d632e:
	bl L_8c02c0
L_8d6332:
	mov_s r13,r0
L_8d6334:
	mov_s r15,r1
L_8d6336:
	mov_s r14,r2
L_8d6338:
	mov_s r2,0x1002b80
L_8d633e:
	mov_s r0,0xe
L_8d6340:
	bl.d L_8edfb0
L_8d6344:
	mov_s r1,0x2
L_8d6346:
	add3 r0,r13,0x10
L_8d634a:
	st_s r15,[r0,0x10]
L_8d634c:
	st_s r14,[r0,0xc]
L_8d634e:
	ld_s r2,[r14,0xc]
L_8d6350:
	ld_s r2,[r2,0x50]
L_8d6352:
	mov_s r1,0x0
L_8d6354:
	cmp_s r2,0x2
L_8d6356:
	cmp.ne r2,0x3
L_8d635a:
	mov.eq r1,0x1
L_8d635e:
	extb.f r1,r1
L_8d6362:
	st_s r1,[r0,0x14]
L_8d6364:
	beq_s L_8d6370
L_8d6366:
	mov_s r0,r13
L_8d6368:
	bl.d L_8d5924
L_8d636c:
	mov_s r1,r13
L_8d636e:
	b_s L_8d637a
	.global L_8d6370
L_8d6370:
	add2 r0,r13,0x11
L_8d6374:
	bl.d L_8d5a0c
L_8d6378:
	mov_s r1,r13
	.global L_8d637a
L_8d637a:
	b L_8c032c
L_8d637e:
	nop_s
