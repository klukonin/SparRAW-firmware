/* frame__build_addba_req @ 0x8ec5fc, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__send_addba_req
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bf_b_s2_w4, bf_u16_s4_w12, bf_u16_s6_w10, memset0_words
 */
	.section .text.frame__build_addba_req,"ax",@progbits
	.global frame__build_addba_req
frame__build_addba_req:
	.global L_8ec5fc
L_8ec5fc:
	push_s blink
L_8ec5fe:
	bl L_8c02b0
L_8ec602:
	mov_s r13,r0
L_8ec604:
	mov_s r14,r1
L_8ec606:
	mov_s r15,r2
L_8ec608:
	mov_s r16,r3
L_8ec60a:
	mov r17,r4
L_8ec60e:
	mov r18,r5
L_8ec612:
	mov r19,r6
L_8ec616:
	bl.d L_8c1a78
L_8ec61a:
	mov_s r1,0x9
L_8ec61c:
	mov_s r0,0x3
L_8ec61e:
	stb_s r0,[r13]
L_8ec620:
	mov_s r0,0x0
L_8ec622:
	stb_s r0,[r13,0x1]
L_8ec624:
	ldb_s r0,[r13,0x3]
L_8ec626:
	bmsk r1,r19,0x0
L_8ec62a:
	bclr_s r0,r0,0x0
L_8ec62c:
	or_s r0,r0,r1
L_8ec62e:
	bclr_s r0,r0,0x1
L_8ec630:
	stb_s r0,[r13,0x3]
L_8ec632:
	bmsk r1,r16,0x3
L_8ec636:
	add_s r0,r13,0x3
L_8ec638:
	bl.d L_8e8240
L_8ec63c:
	stb_s r14,[r13,0x2]
L_8ec63e:
	bmsk r1,r15,0x9
L_8ec642:
	add_s r0,r13,0x3
L_8ec644:
	bl L_8e8198
L_8ec648:
	stb r17,[r13, 0x5]
L_8ec64c:
	lsr r17,r17,0x8
L_8ec650:
	bmsk r1,r18,0xb
L_8ec654:
	add_s r0,r13,0x7
L_8ec656:
	bl.d L_8e8174
L_8ec65a:
	stb r17,[r13, 0x6]
L_8ec65e:
	b.d L_8c030c
L_8ec662:
	mov_s r0,0x9
