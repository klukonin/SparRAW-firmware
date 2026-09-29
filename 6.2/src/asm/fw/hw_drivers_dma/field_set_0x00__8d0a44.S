/* field_set_0x00__8d0a44 @ 0x8d0a44, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x00__8d0a44
field_set_0x00__8d0a44:
	.global L_8d0a44
L_8d0a44:
	push_s blink
L_8d0a46:
	bl.d L_8c01e0
L_8d0a4a:
	asl_s r1,r1
L_8d0a4c:
	mul64 r0,0x380
L_8d0a50:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_8d0a52:
	/* asl_s r3,r3,0x3 */
	.byte 0x03,0xbb
L_8d0a54:
	or_s r1,r1,r2
L_8d0a56:
	asl r15,r4,0x5
L_8d0a5a:
	or_s r3,r3,r1
L_8d0a5c:
	asl r14,r5,0x6
L_8d0a60:
	or_s r15,r15,r3
L_8d0a62:
	asl r13,r6,0x4
L_8d0a66:
	add r0,mlo,0x44096e0
L_8d0a6e:
	or_s r14,r14,r15
L_8d0a70:
	or_s r13,r13,r14
L_8d0a72:
	lsr_s r0,r0,0x3
L_8d0a74:
	st_s r13,[r0]
L_8d0a76:
	sync
L_8d0a7a:
	b L_8c024c
L_8d0a7e:
	nop_s
