/* rfc__write_packed_fields @ 0x8d0dc4, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__configure_chain
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, rfc_field_write
 */
	.section .text.rfc__write_packed_fields,"ax",@progbits
	.global rfc__write_packed_fields
rfc__write_packed_fields:
	.global L_8d0dc4
L_8d0dc4:
	push_s blink
L_8d0dc6:
	bl.d L_8c02c0
L_8d0dca:
	bmsk_s r1,r1,0x1
L_8d0dcc:
	mov_s r14,r5
L_8d0dce:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_8d0dd0:
	bic r2,r2,-0x1d
L_8d0dd4:
	bic r5,r1,0x1c
L_8d0dd8:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8d0dda:
	mov r1,0x1e0
L_8d0dde:
	asl r15,r4,0x9
L_8d0de2:
	and r15,r15,0x1e00
L_8d0dea:
	and_s r3,r3,r1
L_8d0dec:
	asl r4,r14,0xd
L_8d0df0:
	asl r13,r6,0x11
L_8d0df4:
	and r13,r13,0x20000
L_8d0dfc:
	and r14,r4,0x1e000
L_8d0e04:
	asl r0,r7,0x12
L_8d0e08:
	and r4,r0,0x40000
L_8d0e10:
	mov_s r0,0xfff8001f
L_8d0e16:
	and r0,r0,r5
L_8d0e1a:
	or_s r2,r2,r0
L_8d0e1c:
	or_s r2,r2,r3
L_8d0e1e:
	or_s r2,r2,r15
L_8d0e20:
	or_s r2,r2,r14
L_8d0e22:
	or_s r2,r2,r13
L_8d0e24:
	mov_s r0,0x0
L_8d0e26:
	mov r1,0x33c
L_8d0e2a:
	bl.d L_8d113c
L_8d0e2e:
	or r2,r2,r4
L_8d0e32:
	b L_8c032c
L_8d0e36:
	nop_s
