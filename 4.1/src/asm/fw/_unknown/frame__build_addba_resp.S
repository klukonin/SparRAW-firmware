/* frame__build_addba_resp @ 0x8ec664, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba__send_addba_resp, wmi_handler_rcp_addba_resp
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bf_b_s2_w4, bf_u16_s6_w10, memset0_words
 */
	.section .text.frame__build_addba_resp,"ax",@progbits
	.global frame__build_addba_resp
frame__build_addba_resp:
	.global L_8ec664
L_8ec664:
	push_s blink
L_8ec666:
	bl L_8c02b0
L_8ec66a:
	mov_s r13,r0
L_8ec66c:
	mov_s r14,r1
L_8ec66e:
	mov_s r15,r2
L_8ec670:
	mov_s r16,r3
L_8ec672:
	mov r17,r4
L_8ec676:
	mov r18,r5
L_8ec67a:
	mov r19,r6
L_8ec67e:
	bl.d L_8c1a78
L_8ec682:
	mov_s r1,0x9
L_8ec684:
	mov_s r0,0x3
L_8ec686:
	stb_s r0,[r13]
L_8ec688:
	mov_s r0,0x1
L_8ec68a:
	stb_s r0,[r13,0x1]
L_8ec68c:
	stb_s r14,[r13,0x2]
L_8ec68e:
	stb r18,[r13, 0x3]
L_8ec692:
	lsr r18,r18,0x8
L_8ec696:
	ldb_s r0,[r13,0x5]
L_8ec698:
	bmsk r1,r19,0x0
L_8ec69c:
	bclr_s r0,r0,0x0
L_8ec69e:
	or_s r0,r0,r1
L_8ec6a0:
	bclr_s r0,r0,0x1
L_8ec6a2:
	stb_s r0,[r13,0x5]
L_8ec6a4:
	bmsk r1,r16,0x3
L_8ec6a8:
	add_s r0,r13,0x5
L_8ec6aa:
	bl.d L_8e8240
L_8ec6ae:
	stb r18,[r13, 0x4]
L_8ec6b2:
	bmsk r1,r15,0x9
L_8ec6b6:
	add_s r0,r13,0x5
L_8ec6b8:
	bl L_8e8198
L_8ec6bc:
	stb r17,[r13, 0x7]
L_8ec6c0:
	lsr r17,r17,0x8
L_8ec6c4:
	stb r17,[r13, 0x8]
L_8ec6c8:
	b.d L_8c030c
L_8ec6cc:
	mov_s r0,0x9
L_8ec6ce:
	nop_s
