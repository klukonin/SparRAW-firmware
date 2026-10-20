/* rf_comm_test @ 0x8c5cac, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MARLON COMM TEST FAILED: EXPECTED=0x%X   ACTUAL=0x%X
 *   FALCON COMM TEST FAILED: EXPECTED=0x%X   ACTUAL=0x%X
 * Зовут его: measure_rssi_using_histogram, otp__log_params, rf__check_state
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2, get_reg_880a7c_8d74c8, tail_hwd_rfc_read_rgf
 */
	.section .text.rf_comm_test,"ax",@progbits
	.global rf_comm_test
rf_comm_test:
	.global L_8c5cac
L_8c5cac:
	push_s blink
L_8c5cae:
	bl L_8c02bc
L_8c5cb2:
	mov_s r14,r0
L_8c5cb4:
	mov_s r16,r1
L_8c5cb6:
	lr r15,[0xa]
L_8c5cba:
	bclr r0,r15,0x1
L_8c5cbe:
	flag r0
L_8c5cc2:
	ldb_s r0,[r14,0x1]
L_8c5cc4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c5cc6:
	bl.d L_8d74c8
L_8c5cca:
	stb_s r0,[r14,0x1]
L_8c5ccc:
	ldb_s r1,[r14,0x1]
L_8c5cce:
	breq_s r0,0,L_8c5cf2
L_8c5cd0:
	btst_s r1,0x0
L_8c5cd2:
	mov_s r2,0xad
L_8c5cd4:
	asl.ne r2,r2,0x4
L_8c5cd8:
	mov.ne r13,0x97479747
L_8c5ce0:
	mov.eq r2,0xad8
L_8c5ce8:
	mov.eq r13,0x4007fd
L_8c5cf0:
	b_s L_8c5d0a
	.global L_8c5cf2
L_8c5cf2:
	btst_s r1,0x0
L_8c5cf4:
	mov.ne r13,0x97479747
L_8c5cfc:
	mov r2,0x3d8
L_8c5d00:
	bne_s L_8c5d0a
L_8c5d02:
	mov r2,0x3e0
L_8c5d06:
	mov r13,0x7fd
	.global L_8c5d0a
L_8c5d0a:
	mov_s r0,r14
L_8c5d0c:
	bl.d L_8ddd74
L_8c5d10:
	mov_s r1,r16
L_8c5d12:
	mov_s r16,r0
L_8c5d14:
	lr r0,[0xa]
L_8c5d18:
	bic r15,r15,-0x3
L_8c5d1c:
	or_s r15,r15,r0
L_8c5d1e:
	flag r15
L_8c5d22:
	mov_s r1,0x0
L_8c5d24:
	brne r13,r16,L_8c5d34
L_8c5d28:
	mov_s r0,0x880a3c
L_8c5d2e:
	st_s r1,[r0,0x2c]
L_8c5d30:
	mov_s r0,0x1
L_8c5d32:
	b_s L_8c5d62
	.global L_8c5d34
L_8c5d34:
	bl L_8d74c8
L_8c5d38:
	breq_s r0,0,L_8c5d42
L_8c5d3a:
	mov_s r2,0x1005388
L_8c5d40:
	b_s L_8c5d48
	.global L_8c5d42
L_8c5d42:
	mov_s r2,0x10053c0
	.global L_8c5d48
L_8c5d48:
	mov_s r0,0x0
L_8c5d4a:
	mov_s r1,r0
L_8c5d4c:
	mov_s r3,r13
L_8c5d4e:
	bl.d L_8edff8
L_8c5d52:
	mov r4,r16
L_8c5d56:
	mov_s r1,0x1
L_8c5d58:
	mov_s r0,0x880a3c
L_8c5d5e:
	st_s r1,[r0,0x2c]
L_8c5d60:
	mov_s r0,0x0
	.global L_8c5d62
L_8c5d62:
	b L_8c0324
L_8c5d66:
	nop_s
