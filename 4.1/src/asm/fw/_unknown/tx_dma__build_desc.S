/* tx_dma__build_desc @ 0x8e4f58, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__program_tx_desc_and_ba
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bf_w_s0_w4, bf_w_s14_w2, bf_w_s16_w7, bf_w_s4_w2, memset0_words, rgf_reg_881b00_8db334
 */
	.section .text.tx_dma__build_desc,"ax",@progbits
	.global tx_dma__build_desc
tx_dma__build_desc:
	.global L_8e4f58
L_8e4f58:
	push_s blink
L_8e4f5a:
	bl L_8c02b0
L_8e4f5e:
	mov_s r13,r0
L_8e4f60:
	mov_s r14,r1
L_8e4f62:
	mov_s r15,r2
L_8e4f64:
	mov_s r16,r3
L_8e4f66:
	mov r17,r4
L_8e4f6a:
	mov r18,r5
L_8e4f6e:
	mov r19,r6
L_8e4f72:
	bl.d L_8c1a78
L_8e4f76:
	mov_s r1,0x10
L_8e4f78:
	ldw_s r0,[r14]
L_8e4f7a:
	bmsk r1,r16,0x3
L_8e4f7e:
	stw_s r0,[r13]
L_8e4f80:
	ldw_s r0,[r14,0x2]
L_8e4f82:
	stw_s r0,[r13,0x2]
L_8e4f84:
	ldw_s r0,[r14,0x4]
L_8e4f86:
	stw_s r0,[r13,0x4]
L_8e4f88:
	ldw_s r0,[r15]
L_8e4f8a:
	stw_s r0,[r13,0x6]
L_8e4f8c:
	ldw_s r0,[r15,0x2]
L_8e4f8e:
	stw_s r0,[r13,0x8]
L_8e4f90:
	ldw_s r0,[r15,0x4]
L_8e4f92:
	stw_s r0,[r13,0xa]
L_8e4f94:
	add r0,r13,0xc
L_8e4f98:
	bl.d L_8e8348
L_8e4f9c:
	and r2,r19,0x2
L_8e4fa0:
	bmsk r1,r17,0x1
L_8e4fa4:
	bl.d L_8e84d4
L_8e4fa8:
	asr_s r2,r2
L_8e4faa:
	bmsk r1,r18,0x6
L_8e4fae:
	bl L_8e83e4
L_8e4fb2:
	bmsk r1,r19,0x0
L_8e4fb6:
	asl_s r1,r1
L_8e4fb8:
	or_s r1,r1,r2
L_8e4fba:
	bl L_8e839c
L_8e4fbe:
	bl L_8db334
L_8e4fc2:
	b L_8c030c
L_8e4fc6:
	nop_s
