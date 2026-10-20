/* uc_evt__queue_put @ 0x9349dc, 312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_evt__enqueue
 * Зовёт сам: list__push_locked, mailbox__free_space, mailbox_debug_dump_uc, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__queue_put
uc_evt__queue_put:
	.global L_9349dc
L_9349dc:
	st.a r13,[sp,-0x2c]
L_9349e0:
	st blink,[sp, 0x4]
L_9349e4:
	st_s r14,[sp,0x8]
L_9349e6:
	st_s r15,[sp,0xc]
L_9349e8:
	st r16,[sp, 0x10]
L_9349ec:
	st r17,[sp, 0x14]
L_9349f0:
	st r18,[sp, 0x18]
L_9349f4:
	st r19,[sp, 0x1c]
L_9349f8:
	st r20,[sp, 0x20]
L_9349fc:
	st r21,[sp, 0x24]
L_934a00:
	st r22,[sp, 0x28]
L_934a04:
	mov_s r16,r0
L_934a06:
	mov.f r15,r1
L_934a0a:
	mov_s r18,r2
L_934a0c:
	mov_s r21,r3
L_934a0e:
	mov r17,r4
L_934a12:
	mov r22,r5
L_934a16:
	mov_s r14,r6
L_934a18:
	beq.d L_934af0
L_934a1c:
	mov r13,r7
	.global L_934a20
L_934a20:
	add r19,r16,0x4
L_934a24:
	bl.d L_92be30
L_934a28:
	mov r0,r19
L_934a2c:
	brne r0,0x0,L_934a44
L_934a30:
	bl.d L_92d608
L_934a34:
	mov r0,r19
L_934a38:
	mov r0,blink
L_934a3c:
	bl.d L_926618
L_934a40:
	mov r1,0xc4
	.global L_934a44
L_934a44:
	sub r15,r15,0x10
L_934a48:
	stw r18,[r15, 0x4]
L_934a4c:
	ldw r6,[r16]
L_934a50:
	mov r20,0x0
L_934a54:
	stw r6,[r15]
L_934a58:
	stb r20,[r15, 0x6]
L_934a5c:
	ld r18,[r19, 0xc]
L_934a60:
	ldw r4,[r18, 0x4]
L_934a64:
	brge r4,r17,L_934a6c
L_934a68:
	breq r14,0x0,L_934b00
	.global L_934a6c
L_934a6c:
	stw r17,[r15, 0x2]
L_934a70:
	stb r17,[r15, 0x7]
L_934a74:
	stb r22,[r15, 0x8]
L_934a78:
	stb r20,[r15, 0x9]
L_934a7c:
	stw r21,[r15, 0xa]
L_934a80:
	st r20,[r15, 0xc]
L_934a84:
	bmsk_s r14,r14,0x0
L_934a86:
	asl_s r3,r14
L_934a88:
	ldw r7,[r15, 0x6]
L_934a8c:
	bmsk_s r13,r13,0x0
L_934a8e:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_934a90:
	bic r2,r7,0x6
L_934a94:
	bclr_s r3,r3,0x2
L_934a96:
	or_s r2,r2,r3
L_934a98:
	ld_s r1,[sp,0x2c]
L_934a9a:
	or_s r2,r2,r13
L_934a9c:
	bmsk_s r1,r1,0x0
L_934a9e:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_934aa0:
	bclr_s r2,r2,0x3
L_934aa2:
	or_s r1,r1,r2
L_934aa4:
	stw_s r1,[r15,0x6]
L_934aa6:
	ldw r0,[r16]
L_934aaa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934aac:
	stw r0,[r16]
L_934ab0:
	mov r0,r19
L_934ab4:
	bl.d L_926984
L_934ab8:
	mov r1,r15
L_934abc:
	ld r5,[r19]
L_934ac0:
	ld blink,[sp, 0x4]
L_934ac4:
	st r5,[r18, 0xc]
L_934ac8:
	ld_s r14,[sp,0x8]
L_934aca:
	ld_s r15,[sp,0xc]
L_934acc:
	ld r16,[sp, 0x10]
L_934ad0:
	ld r17,[sp, 0x14]
L_934ad4:
	ld r18,[sp, 0x18]
L_934ad8:
	ld r19,[sp, 0x1c]
L_934adc:
	ld r20,[sp, 0x20]
L_934ae0:
	ld r21,[sp, 0x24]
L_934ae4:
	ld r22,[sp, 0x28]
L_934ae8:
	j.d [blink]
L_934aec:
	ld.ab r13,[sp,0x2c]
	.global L_934af0
L_934af0:
	mov r0,blink
L_934af4:
	bl.d L_926618
L_934af8:
	mov r1,0xc3
L_934afc:
	b L_934a20
	.global L_934b00
L_934b00:
	brne r13,0x0,L_934a6c
L_934b04:
	mov r0,blink
L_934b08:
	bl.d L_926618
L_934b0c:
	mov r1,0xc5
L_934b10:
	b_s L_934a6c
L_934b12:
	nop_s
