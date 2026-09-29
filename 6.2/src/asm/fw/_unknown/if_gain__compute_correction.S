/* if_gain__compute_correction @ 0x8d55b4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: if_gain
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 * Глобалы (через gp): 0x800227
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global if_gain__compute_correction
if_gain__compute_correction:
	.global L_8d55b4
L_8d55b4:
	push_s blink
L_8d55b6:
	bl L_8c01e0
L_8d55ba:
	ldb_s r3,[r1,0x2]
L_8d55bc:
	mov_s r13,0x842464
L_8d55c2:
	ldb.x r15,[r13, 0x7]
L_8d55c6:
	ldb_s r2,[r1,0x4]
L_8d55c8:
	sub_s r15,r15,0x1d
L_8d55ca:
	sexb_s r15,r15
L_8d55cc:
	rsub r14,r3,0xffffffe6
L_8d55d4:
	sub r3,r0,0x26
L_8d55d8:
	add_s r2,r2,r14
L_8d55da:
	sexb_s r3,r3
L_8d55dc:
	sexb_s r2,r2
L_8d55de:
	sub_s r3,r3,r2
L_8d55e0:
	sexb_s r3,r3
L_8d55e2:
	sub r14,r3,r15
L_8d55e6:
	sexb_s r15,r14
L_8d55e8:
	sub.f r15,r15,0xa
L_8d55ec:
	stb_s r2,[r13,0x5]
L_8d55ee:
	add.mi r15,r15,0x1
L_8d55f2:
	asr_s r15,r15
L_8d55f4:
	add_s r15,r15,0xa
L_8d55f6:
	stb_s r0,[r13,0x8]
L_8d55f8:
	stb_s r3,[r13,0x9]
L_8d55fa:
	stb_s r14,[r13,0xa]
L_8d55fc:
	stb_s r15,[r13,0xc]
L_8d55fe:
	ldw_s r0,[r1,0xc]
L_8d5600:
	extb_s r2,r14
L_8d5602:
	stw_s r0,[r13,0xe]
L_8d5604:
	ldb_s r0,[gp,0xa3]
L_8d5606:
	sub_s r1,r0,0x1
L_8d5608:
	brlt r2,r1,L_8d5614
L_8d560c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d560e:
	cmp_s r2,r0
L_8d5610:
	mov_s r0,0x1
L_8d5612:
	ble_s L_8d5616
	.global L_8d5614
L_8d5614:
	mov_s r0,0x2
	.global L_8d5616
L_8d5616:
	b L_8c024c
L_8d561a:
	nop_s
