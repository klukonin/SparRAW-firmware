/* pcp_factor_evt_step @ 0x8c4a40, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_get_pcp_factor
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_b_s2_w6, bf_u16_s7_w7, bf_w_s0_w7, bf_w_s7_w8
 */
	.section .text.pcp_factor_evt_step,"ax",@progbits
	.global pcp_factor_evt_step
pcp_factor_evt_step:
	.global L_8c4a40
L_8c4a40:
	push_s blink
L_8c4a42:
	bl.d L_8c02c0
L_8c4a46:
	bmsk_s r2,r2,0x0
L_8c4a48:
	sub_s sp,sp,0x4
L_8c4a4a:
	mov_s r13,r1
L_8c4a4c:
	mov_s r14,0x0
L_8c4a4e:
	mov_s r0,sp
L_8c4a50:
	mov_s r1,r14
L_8c4a52:
	bl.d L_8e836c
L_8c4a56:
	asl_s r2,r2
L_8c4a58:
	ldb_s r15,[r13,0x10]
L_8c4a5a:
	ldb_s r1,[r13,0xf]
L_8c4a5c:
	asl_s r15,r15,0x8
L_8c4a5e:
	or_s r1,r1,r15
L_8c4a60:
	lsr_s r1,r1,0x3
L_8c4a62:
	extb_s r1,r1
L_8c4a64:
	bl L_8e8534
L_8c4a68:
	ldb_s r0,[r13,0x8]
L_8c4a6a:
	ldb_s r1,[r13,0x7]
L_8c4a6c:
	asl_s r0,r0,0x8
L_8c4a6e:
	or_s r1,r1,r0
L_8c4a70:
	lsr_s r1,r1,0x7
L_8c4a72:
	bmsk_s r1,r1,0x6
L_8c4a74:
	add r0,sp,0x1
L_8c4a78:
	bl L_8e81e0
L_8c4a7c:
	ldb_s r1,[r13,0xf]
L_8c4a7e:
	ldb r15,[sp, 0x3]
L_8c4a82:
	lsr_s r0,r1
L_8c4a84:
	bmsk_s r0,r0,0x0
L_8c4a86:
	asl r4,r0,0x6
L_8c4a8a:
	ldb r0,[sp, 0x2]
L_8c4a8e:
	asl_s r15,r15,0x8
L_8c4a90:
	or_s r0,r0,r15
L_8c4a92:
	bmsk_s r1,r1,0x0
L_8c4a94:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8c4a96:
	bic r0,r0,0xc0
L_8c4a9a:
	bclr r15,r4,0x7
L_8c4a9e:
	or_s r0,r0,r15
L_8c4aa0:
	or_s r1,r1,r0
L_8c4aa2:
	stb r1,[sp, 0x2]
L_8c4aa6:
	lsr_s r1,r1,0x8
L_8c4aa8:
	ldb_s r0,[r13,0x10]
L_8c4aaa:
	stb r1,[sp, 0x3]
L_8c4aae:
	lsr_s r0,r0,0x4
L_8c4ab0:
	bmsk r1,r0,0x0
L_8c4ab4:
	ldb r0,[sp, 0x3]
L_8c4ab8:
	bclr_s r0,r0,0x0
L_8c4aba:
	or_s r0,r0,r1
L_8c4abc:
	bclr_s r0,r0,0x1
L_8c4abe:
	or_s r0,r0,r2
L_8c4ac0:
	stb r0,[sp, 0x3]
L_8c4ac4:
	add r0,sp,0x3
L_8c4ac8:
	mov_s r1,r14
L_8c4aca:
	bl L_8e8258
L_8c4ace:
	ld_s r0,[sp,0x0]
L_8c4ad0:
	st_s r0,[r3]
L_8c4ad2:
	b.d L_8c032c
L_8c4ad6:
	add_s sp,sp,0x4
