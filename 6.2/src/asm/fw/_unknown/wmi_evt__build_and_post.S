/* wmi_evt__build_and_post @ 0x8e4ff8, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__post_cmd, wmi_evt__post
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, fw_sysassert_fatal, mailbox_debug_dump, mbox_ring__advance, u_schd__now, wmi_evt__fill_payload
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_evt__build_and_post
wmi_evt__build_and_post:
	.global L_8e4ff8
L_8e4ff8:
	push_s blink
L_8e4ffa:
	bl L_8c01c4
L_8e4ffe:
	mov_s r15,r0
L_8e5000:
	mov.f r13,r1
L_8e5004:
	mov_s r17,r2
L_8e5006:
	mov_s r16,r3
L_8e5008:
	mov r21,r4
L_8e500c:
	mov r20,r5
L_8e5010:
	mov r18,r6
L_8e5014:
	mov r19,r7
L_8e5018:
	beq_s L_8e50a8
	.global L_8e501a
L_8e501a:
	add_s r14,r15,0x4
L_8e501c:
	bl.d L_8da460
L_8e5020:
	mov_s r0,r14
L_8e5022:
	brne_s r0,0,L_8e5032
L_8e5024:
	bl.d L_8ddab4
L_8e5028:
	mov_s r0,r14
L_8e502a:
	mov_s r0,blink
L_8e502c:
	bl.d L_8c9b28
L_8e5030:
	mov_s r1,0xc4
	.global L_8e5032
L_8e5032:
	sub_s r13,r13,0x10
L_8e5034:
	stw r17,[r13, 0x4]
L_8e5038:
	ldw_s r0,[r15]
L_8e503a:
	stw_s r0,[r13]
L_8e503c:
	mov_s r0,0x0
L_8e503e:
	stb_s r0,[r13,0x6]
L_8e5040:
	ld r17,[r14, 0xc]
L_8e5044:
	mov_s r22,r0
L_8e5046:
	ldw r0,[r17, 0x4]
L_8e504a:
	brge r0,r21,L_8e5052
L_8e504e:
	breq r18,0x0,L_8e50b2
	.global L_8e5052
L_8e5052:
	stw r21,[r13, 0x2]
L_8e5056:
	stb r21,[r13, 0x7]
L_8e505a:
	stb r20,[r13, 0x8]
L_8e505e:
	stb r22,[r13, 0x9]
L_8e5062:
	bl.d L_8e9524
L_8e5066:
	stw r16,[r13, 0xa]
L_8e506a:
	st_s r0,[r13,0xc]
L_8e506c:
	bmsk r0,r18,0x0
L_8e5070:
	asl_s r0,r0
L_8e5072:
	ldw_s r1,[r13,0x6]
L_8e5074:
	bmsk r2,r19,0x0
L_8e5078:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_8e507a:
	bic r1,r1,0x6
L_8e507e:
	bclr_s r0,r0,0x2
L_8e5080:
	or_s r1,r1,r0
L_8e5082:
	ld_s r0,[sp,0x2c]
L_8e5084:
	or_s r1,r1,r2
L_8e5086:
	bmsk_s r0,r0,0x0
L_8e5088:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_8e508a:
	bclr_s r1,r1,0x3
L_8e508c:
	or_s r0,r0,r1
L_8e508e:
	stw_s r0,[r13,0x6]
L_8e5090:
	ldw_s r0,[r15]
L_8e5092:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5094:
	stw_s r0,[r15]
L_8e5096:
	mov_s r0,r14
L_8e5098:
	bl.d L_8cadf8
L_8e509c:
	mov_s r1,r13
L_8e509e:
	ld_s r1,[r14]
L_8e50a0:
	b.d L_8c0214
L_8e50a4:
	st r1,[r17, 0xc]
	.global L_8e50a8
L_8e50a8:
	mov_s r0,blink
L_8e50aa:
	bl.d L_8c9b28
L_8e50ae:
	mov_s r1,0xc3
L_8e50b0:
	b_s L_8e501a
	.global L_8e50b2
L_8e50b2:
	cmp r19,0x0
L_8e50b6:
	mov.eq r0,blink
L_8e50ba:
	mov.eq r1,0xc5
L_8e50c2:
	bl.eq L_8c9b28
L_8e50c6:
	b_s L_8e5052
