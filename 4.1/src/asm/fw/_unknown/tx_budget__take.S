/* tx_budget__take @ 0x8ef7d8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: tx_budget__arm_refill
 */
	.section .text.tx_budget__take,"ax",@progbits
	.global tx_budget__take
tx_budget__take:
L_8ef7d8:
	push_s blink
L_8ef7da:
	ld_s r1,[r0,0x4]
L_8ef7dc:
	ldw_s r2,[r0,0xc]
L_8ef7de:
	cmp_s r1,r2
L_8ef7e0:
	mov.cc r0,0x0
L_8ef7e4:
	bhs_s L_8ef7fe
L_8ef7e6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8ef7e8:
	st_s r1,[r0,0x4]
L_8ef7ea:
	ld_s r1,[r0,0x18]
L_8ef7ec:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8ef7ee:
	st_s r1,[r0,0x18]
L_8ef7f0:
	ld_s r1,[r0,0x14]
L_8ef7f2:
	cmp_s r1,0x0
L_8ef7f4:
	bl.ne.d L_8ea4f0
L_8ef7f8:
	mov.ne r1,0x1
L_8ef7fc:
	mov_s r0,0x1
	.global L_8ef7fe
L_8ef7fe:
	pop_s blink
L_8ef800:
	j_s [blink]
L_8ef802:
	nop_s
