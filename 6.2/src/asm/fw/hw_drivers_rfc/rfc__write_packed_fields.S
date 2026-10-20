/* rfc__write_packed_fields @ 0x8d3e80, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__configure_chain
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__write_packed_fields
rfc__write_packed_fields:
	.global L_8d3e80
L_8d3e80:
	push_s blink
L_8d3e82:
	bl.d L_8c01e0
L_8d3e86:
	bmsk_s r1,r1,0x1
L_8d3e88:
	mov_s r14,r5
L_8d3e8a:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_8d3e8c:
	bic r2,r2,-0x1d
L_8d3e90:
	bic r5,r1,0x1c
L_8d3e94:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8d3e96:
	mov r1,0x1e0
L_8d3e9a:
	asl r15,r4,0x9
L_8d3e9e:
	and r15,r15,0x1e00
L_8d3ea6:
	and_s r3,r3,r1
L_8d3ea8:
	asl r4,r14,0xd
L_8d3eac:
	asl r13,r6,0x11
L_8d3eb0:
	and r13,r13,0x20000
L_8d3eb8:
	and r14,r4,0x1e000
L_8d3ec0:
	asl r0,r7,0x12
L_8d3ec4:
	and r4,r0,0x40000
L_8d3ecc:
	mov_s r0,0xfff8001f
L_8d3ed2:
	and r0,r0,r5
L_8d3ed6:
	or_s r2,r2,r0
L_8d3ed8:
	or_s r2,r2,r3
L_8d3eda:
	or_s r2,r2,r15
L_8d3edc:
	or_s r2,r2,r14
L_8d3ede:
	or_s r2,r2,r13
L_8d3ee0:
	mov_s r0,0x0
L_8d3ee2:
	mov r1,0x33c
L_8d3ee6:
	bl.d L_8d4308
L_8d3eea:
	or r2,r2,r4
L_8d3eee:
	b L_8c024c
L_8d3ef2:
	nop_s
