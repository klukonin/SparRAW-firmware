/* frame__build_delba @ 0x8ec860, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__send_delba, wmi_handler_rcp_delba
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_b_s4_w4, memset0_words
 */
	.section .text.frame__build_delba,"ax",@progbits
	.global frame__build_delba
frame__build_delba:
	.global L_8ec860
L_8ec860:
	push_s blink
L_8ec862:
	bl L_8c02bc
L_8ec866:
	mov_s r13,r0
L_8ec868:
	mov_s r15,r1
L_8ec86a:
	mov_s r16,r2
L_8ec86c:
	mov_s r14,r3
L_8ec86e:
	bl.d L_8c1a78
L_8ec872:
	mov_s r1,0x6
L_8ec874:
	mov_s r0,0x3
L_8ec876:
	stb_s r0,[r13]
L_8ec878:
	mov_s r0,0x2
L_8ec87a:
	stb_s r0,[r13,0x1]
L_8ec87c:
	bmsk r1,r16,0x3
L_8ec880:
	add_s r0,r13,0x3
L_8ec882:
	bl.d L_8e8270
L_8ec886:
	bmsk_s r15,r15,0x0
L_8ec888:
	ldb_s r0,[r13,0x3]
L_8ec88a:
	/* asl_s r15,r15,0x3 */
	.byte 0x03,0xbf
L_8ec88c:
	bclr_s r0,r0,0x3
L_8ec88e:
	or_s r0,r0,r15
L_8ec890:
	stb_s r0,[r13,0x3]
L_8ec892:
	stw_s r14,[r13,0x4]
L_8ec894:
	b.d L_8c0324
L_8ec898:
	mov_s r0,0x6
L_8ec89a:
	nop_s
