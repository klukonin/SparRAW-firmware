/* txrx_api_step_c @ 0x9319e8, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x04_handler
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc
 */
	.section .text.txrx_api_step_c,"ax",@progbits
	.global txrx_api_step_c
txrx_api_step_c:
	.global L_9319e8
L_9319e8:
	push_s blink
L_9319ea:
	bl L_920214
L_9319ee:
	mov_s r14,r0
L_9319f0:
	mov_s r13,r1
L_9319f2:
	ldw_s r0,[r1,0x4]
L_9319f4:
	mov_s r1,0x0
L_9319f6:
	bset r1,r1,r0
L_9319fa:
	ldw_s r0,[r13,0x8]
L_9319fc:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_9319fe:
	asl_s r0,r0,0x1c
L_931a00:
	or r0,r0,0x1ff
L_931a04:
	mov_s r2,0x886d68
L_931a0a:
	add2_s r2,r2,r14
L_931a0c:
	st_s r0,[r2]
L_931a0e:
	mov_s r0,0xc0adc0ad
L_931a14:
	asl_s r0,r0,r14
L_931a16:
	mov_s r2,0x886d78
L_931a1c:
	add2_s r2,r2,r14
L_931a1e:
	st_s r0,[r2]
L_931a20:
	add r0,r14,0x9
L_931a24:
	asl_s r0,r0,0x18
L_931a26:
	or_s r0,r0,r1
L_931a28:
	mov_s r32,r0
L_931a2a:
	st.ab r0,[r25,0x4]
L_931a2e:
	bclr r25,r25,0xa
L_931a32:
	mov_s r0,0x0
L_931a34:
	add r1,r14,0x14
L_931a38:
	bset r0,r0,r1
L_931a3c:
	add r2,r14,0x8
L_931a40:
	bset r1,r0,r2
L_931a44:
	ld_s r0,[gp,-0x20]
L_931a46:
	bic_s r0,r0,r1
L_931a48:
	or_s r0,r0,r1
L_931a4a:
	st.as r0,[gp,-0x8]
L_931a4e:
	bset_s r0,r0,0x18
L_931a50:
	bset_s r0,r0,0x19
L_931a52:
	bset_s r0,r0,0x1a
L_931a54:
	mov_s r32,r0
L_931a56:
	st.ab r0,[r25,0x4]
L_931a5a:
	bclr r25,r25,0xa
L_931a5e:
	ldw_s r1,[r13,0x4]
L_931a60:
	mov_s r0,0x800ac8
L_931a66:
	add2_s r0,r0,r14
L_931a68:
	stb_s r1,[r0]
L_931a6a:
	ldw_s r1,[r13,0x4]
L_931a6c:
	stb_s r1,[r0,0x2]
L_931a6e:
	ldw_s r1,[r13,0x6]
L_931a70:
	b.d L_920284
L_931a74:
	stb_s r1,[r0,0x1]
L_931a76:
	nop_s
