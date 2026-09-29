/* tx_api__prepare_descriptor @ 0x8e0a80, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_w_s0_w4, bf_w_s4_w28, fw_sysassert_fatal
 */
	.section .text.tx_api__prepare_descriptor,"ax",@progbits
	.global tx_api__prepare_descriptor
tx_api__prepare_descriptor:
L_8e0a80:
	mov_s r0,r15
	.global sub_8e0a82
sub_8e0a82:
L_8e0a82:
	nop_s
L_8e0a84:
	push_s blink
L_8e0a86:
	bl.d L_8c02c0
L_8e0a8a:
	mov_s r1,0x0
L_8e0a8c:
	ld_s r2,[r0,0x30]
L_8e0a8e:
	mov_s r15,r0
L_8e0a90:
	ld_s r0,[r2]
L_8e0a92:
	sub_s sp,sp,0x18
L_8e0a94:
	sub.f r0,r0,0x0
L_8e0a98:
	mov.ne r0,0x1
L_8e0a9c:
	extb.f 0x0,r0
L_8e0aa0:
	mov.eq r0,r1
L_8e0aa4:
	beq_s L_8e0b30
L_8e0aa6:
	ld_s r13,[r2,0x4]
L_8e0aa8:
	add_s r14,sp,0x8
L_8e0aaa:
	breq_s r13,0,L_8e0ad0
	.global L_8e0aac
L_8e0aac:
	st_s r13,[r14]
L_8e0aae:
	add_s r13,r13,0x1c
L_8e0ab0:
	st_s r13,[r14,0x4]
L_8e0ab2:
	ld_s r0,[sp,0x8]
L_8e0ab4:
	mov_s r3,0x0
L_8e0ab6:
	ldw_s r2,[r0,0xc]
L_8e0ab8:
	bmsk.f 0x0,r2,0x2
L_8e0abc:
	st_s r3,[sp,0x14]
L_8e0abe:
	beq_s L_8e0af6
L_8e0ac0:
	mov_s r1,0x2
L_8e0ac2:
	add_s r0,sp,0x14
L_8e0ac4:
	bl.d L_8e8348
L_8e0ac8:
	btst_s r2,0x0
L_8e0aca:
	beq_s L_8e0ae6
L_8e0acc:
	mov_s r1,r3
L_8e0ace:
	b_s L_8e0af2
	.global L_8e0ad0
L_8e0ad0:
	mov_s r0,blink
L_8e0ad2:
	mov_s r2,0x101585c
L_8e0ad8:
	mov_s r1,0x11d6
L_8e0ade:
	bl.d L_8c82c0
L_8e0ae2:
	mov_s r3,0xaa
L_8e0ae4:
	b_s L_8e0aac
	.global L_8e0ae6
L_8e0ae6:
	btst_s r2,0x2
L_8e0ae8:
	mov.ne r1,0x1
L_8e0aec:
	btst.eq r2,0x1
L_8e0af0:
	beq_s L_8e0af6
	.global L_8e0af2
L_8e0af2:
	bl L_8e84e0
	.global L_8e0af6
L_8e0af6:
	ld_s r1,[sp,0x14]
L_8e0af8:
	bbit0 r2,0x3,L_8e0b06
L_8e0afc:
	bmsk_s r1,r1,0x3
L_8e0afe:
	bset_s r1,r1,0x2
L_8e0b00:
	add_s r0,sp,0x14
L_8e0b02:
	bl L_8e8348
	.global L_8e0b06
L_8e0b06:
	ld_s r2,[sp,0x8]
L_8e0b08:
	ld r0,[r15, 0x8c]
L_8e0b0c:
	ldb_s r1,[r2,0xa]
L_8e0b0e:
	ldb_s r13,[r2,0xb]
L_8e0b10:
	st_s r1,[sp,0x0]
L_8e0b12:
	ld_s r1,[sp,0x14]
L_8e0b14:
	ldb r4,[r2, 0x10]
L_8e0b18:
	st_s r1,[sp,0x4]
L_8e0b1a:
	ld_s r1,[r0]
L_8e0b1c:
	ldw_s r2,[r2,0x8]
L_8e0b1e:
	mov_s r3,0x0
L_8e0b20:
	ld_s r14,[r1,0x4]
L_8e0b22:
	mov_s r5,r3
L_8e0b24:
	ld_s r1,[sp,0xc]
L_8e0b26:
	mov r6,0x1
L_8e0b2a:
	jl_s.d [r14]
L_8e0b2c:
	bmsk r7,r13,0x5
	.global L_8e0b30
L_8e0b30:
	b.d L_8c032c
L_8e0b34:
	add_s sp,sp,0x18
L_8e0b36:
	nop_s
