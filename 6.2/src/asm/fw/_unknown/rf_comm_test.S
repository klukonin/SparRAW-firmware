/* rf_comm_test @ 0x8c6a40, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MARLON COMM TEST FAILED: EXPECTED=0x%X   ACTUAL=0x%X
 *   SPARROW-R COMM TEST FAILED: EXPECTED=0x%X   ACTUAL=0x%X
 * Зовут его: otp_init, rf__check_state, silent_rssi__hist_window_index
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, hwd_rfc_read_rgf, rf__type_is_marlon
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_comm_test
rf_comm_test:
	.global L_8c6a40
L_8c6a40:
	push_s blink
L_8c6a42:
	bl L_8c01e0
L_8c6a46:
	mov_s r14,r1
L_8c6a48:
	lr r15,[0xa]
L_8c6a4c:
	bclr r1,r15,0x1
L_8c6a50:
	flag r1
L_8c6a54:
	mov_s r13,r0
L_8c6a56:
	add r13,r13,0x460
L_8c6a5a:
	ldb_s r0,[r13,0x11]
L_8c6a5c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c6a5e:
	extb_s r0,r0
L_8c6a60:
	bl.d L_8da594
L_8c6a64:
	stb_s r0,[r13,0x11]
L_8c6a66:
	ldb_s r1,[r13,0x11]
L_8c6a68:
	breq_s r0,0,L_8c6a8c
L_8c6a6a:
	btst_s r1,0x0
L_8c6a6c:
	mov_s r1,0xad
L_8c6a6e:
	asl.ne r1,r1,0x4
L_8c6a72:
	mov.ne r13,0x97479747
L_8c6a7a:
	mov.eq r1,0xad8
L_8c6a82:
	mov.eq r13,0x4007fd
L_8c6a8a:
	b_s L_8c6aa4
	.global L_8c6a8c
L_8c6a8c:
	btst_s r1,0x0
L_8c6a8e:
	mov.ne r13,0x97479747
L_8c6a96:
	mov r1,0x3d8
L_8c6a9a:
	bne_s L_8c6aa4
L_8c6a9c:
	mov r1,0x3e0
L_8c6aa0:
	mov r13,0x7fd
	.global L_8c6aa4
L_8c6aa4:
	bl.d L_8d3588
L_8c6aa8:
	extb_s r0,r14
L_8c6aaa:
	mov_s r14,r0
L_8c6aac:
	lr r0,[0xa]
L_8c6ab0:
	bic r15,r15,-0x3
L_8c6ab4:
	or_s r15,r15,r0
L_8c6ab6:
	flag r15
L_8c6aba:
	mov_s r1,0x0
L_8c6abc:
	brne r14,r13,L_8c6acc
L_8c6ac0:
	mov_s r0,0x880a3c
L_8c6ac6:
	st_s r1,[r0,0x2c]
L_8c6ac8:
	mov_s r0,0x1
L_8c6aca:
	b_s L_8c6af6
	.global L_8c6acc
L_8c6acc:
	bl L_8da594
L_8c6ad0:
	breq_s r0,0,L_8c6ada
L_8c6ad2:
	mov_s r1,0x1005254
L_8c6ad8:
	b_s L_8c6ae0
	.global L_8c6ada
L_8c6ada:
	mov_s r1,0x100528c
	.global L_8c6ae0
L_8c6ae0:
	mov_s r0,0x0
L_8c6ae2:
	mov_s r2,r13
L_8c6ae4:
	bl.d L_8dcc80
L_8c6ae8:
	mov_s r3,r14
L_8c6aea:
	mov_s r1,0x1
L_8c6aec:
	mov_s r0,0x880a3c
L_8c6af2:
	st_s r1,[r0,0x2c]
L_8c6af4:
	mov_s r0,0x0
	.global L_8c6af6
L_8c6af6:
	b L_8c024c
L_8c6afa:
	nop_s
