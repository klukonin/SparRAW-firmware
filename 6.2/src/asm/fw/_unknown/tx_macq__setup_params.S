/* tx_macq__setup_params @ 0x8c6e44, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_macq__setup, vring__configure_tx
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, ba_sm__addba_at_10, qh__write_or_conn_alloc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_macq__setup_params
tx_macq__setup_params:
	.global L_8c6e44
L_8c6e44:
	push_s blink
L_8c6e46:
	bl.d L_8c01dc
L_8c6e4a:
	mov r5,r4
L_8c6e4e:
	sub_s sp,sp,0x70
L_8c6e50:
	mov_s r13,r0
L_8c6e52:
	mov_s r15,r1
L_8c6e54:
	mov_s r14,r2
L_8c6e56:
	stb_s r1,[r0,0xd]
L_8c6e58:
	stb_s r3,[r0,0xf]
L_8c6e5a:
	bmsk r1,r2,0x0
L_8c6e5e:
	ldw_s r0,[r0,0xe]
L_8c6e60:
	asl_s r1,r1
L_8c6e62:
	bclr_s r0,r0,0x1
L_8c6e64:
	or_s r0,r0,r1
L_8c6e66:
	stw_s r0,[r13,0xe]
L_8c6e68:
	mov r16,sp
L_8c6e6c:
	ldb r4,[r13, 0xf]
L_8c6e70:
	mov_s r0,r13
L_8c6e72:
	mov_s r1,r16
L_8c6e74:
	mov_s r2,r15
L_8c6e76:
	bl.d L_8c7edc
L_8c6e7a:
	mov_s r3,r14
L_8c6e7c:
	ldb_s r0,[r13,0xa]
L_8c6e7e:
	mov_s r1,0x2
L_8c6e80:
	mov_s r2,r16
L_8c6e82:
	bl.d L_8ea5b0
L_8c6e86:
	mov_s r3,0x0
L_8c6e88:
	b.d L_8c0244
L_8c6e8c:
	add_s sp,sp,0x70
L_8c6e8e:
	nop_s
