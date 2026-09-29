/* pcie__dbi_transfer @ 0x8eaae8, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_pcie_dbi_write, pcie__dbi_write_shadow
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, pcie__ack_882644, set_reg_882600, set_reg_882644, set_reg_88264c, set_reg_882650
 */
	.section .text.pcie__dbi_transfer,"ax",@progbits
	.global pcie__dbi_transfer
pcie__dbi_transfer:
	.global L_8eaae8
L_8eaae8:
	push_s blink
L_8eaaea:
	bl L_8c02ac
L_8eaaee:
	mov_s r20,r1
L_8eaaf0:
	mov_s r14,r2
L_8eaaf2:
	mov_s r15,r3
L_8eaaf4:
	mov r19,r4
L_8eaaf8:
	mov r17,r5
L_8eaafc:
	mov_s r13,r6
L_8eaafe:
	mov r18,r7
L_8eab02:
	bl.d L_8ce4dc
L_8eab06:
	mov r16,0x0
L_8eab0a:
	bl.d L_8ce768
L_8eab0e:
	mov_s r0,r20
L_8eab10:
	brne r19,0x0,L_8eab2a
L_8eab14:
	cmp_s r15,0x0
L_8eab16:
	mov.ne r0,r16
L_8eab1a:
	bne_s L_8eab34
L_8eab1c:
	breq_s r14,0,L_8eab2a
L_8eab1e:
	breq r14,0x1,L_8eab2e
L_8eab22:
	breq r14,0x2,L_8eab32
L_8eab26:
	mov_s r0,r16
L_8eab28:
	b_s L_8eab8e
	.global L_8eab2a
L_8eab2a:
	mov_s r0,0x1
L_8eab2c:
	b_s L_8eab34
	.global L_8eab2e
L_8eab2e:
	mov_s r0,0x2
L_8eab30:
	b_s L_8eab34
	.global L_8eab32
L_8eab32:
	mov_s r0,0x4
	.global L_8eab34
L_8eab34:
	bmsk_s r0,r0,0x2
L_8eab36:
	bmsk_s r15,r15,0x0
L_8eab38:
	/* asl_s r15,r15,0x3 */
	.byte 0x03,0xbf
L_8eab3a:
	or r1,r15,r0
L_8eab3e:
	bmsk r0,r19,0x0
L_8eab42:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8eab44:
	or_s r1,r1,r0
L_8eab46:
	bmsk r0,r17,0x1
L_8eab4a:
	/* asl_s r0,r0,0x5 */
	.byte 0x05,0xb8
L_8eab4c:
	or_s r1,r1,r0
L_8eab4e:
	bmsk r0,r18,0x0
L_8eab52:
	asl_s r0,r0,0x8
L_8eab54:
	or_s r1,r1,r0
L_8eab56:
	bmsk r0,r13,0x0
L_8eab5a:
	asl_s r0,r0,0xb
L_8eab5c:
	or_s r1,r1,r0
L_8eab5e:
	ldb_s r0,[sp,0x24]
L_8eab60:
	mov_s r14,0x1
L_8eab62:
	bmsk_s r0,r0,0x0
L_8eab64:
	/* asl_s r0,r0,0x7 */
	.byte 0x07,0xb8
L_8eab66:
	or_s r1,r1,r0
L_8eab68:
	mov_s r0,r14
L_8eab6a:
	and r1,r1,0x9ff
L_8eab72:
	bl.d L_8ce4e8
L_8eab76:
	mov_s r2,0xf
L_8eab78:
	brne r13,0x1,L_8eab82
L_8eab7c:
	bl L_8eec3c
L_8eab80:
	b_s L_8eab8e
	.global L_8eab82
L_8eab82:
	cmp_s r13,0x0
L_8eab84:
	sub_s.ne r0,r0,r0
L_8eab86:
	bne_s L_8eab8e
L_8eab88:
	bl L_8ce4a4
L_8eab8c:
	mov_s r0,r14
	.global L_8eab8e
L_8eab8e:
	b L_8c0304
L_8eab92:
	nop_s
