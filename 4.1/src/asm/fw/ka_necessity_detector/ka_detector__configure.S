/* ka_detector__configure @ 0x8c5a70, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ka_necessity_detector.cpp
 * Зовут его: ka_detector__rearm, ka_necessity_detector__start_monitoring
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, ka_detector__is_active
 */
	.section .text.ka_detector__configure,"ax",@progbits
	.global ka_detector__configure
ka_detector__configure:
	.global L_8c5a70
L_8c5a70:
	push_s blink
L_8c5a72:
	bl L_8c02c4
L_8c5a76:
	bl.d L_8d72b0
L_8c5a7a:
	mov_s r14,r0
L_8c5a7c:
	breq_s r0,0,L_8c5aac
L_8c5a7e:
	add r13,r14,0x20
L_8c5a82:
	ldb_s r0,[r13,0x10]
L_8c5a84:
	brge r0,0x8,L_8c5ab4
	.global L_8c5a88
L_8c5a88:
	ldb_s r1,[r13,0x10]
L_8c5a8a:
	ld_s r0,[r14,0x34]
L_8c5a8c:
	asl_s r2,r1,0x2
L_8c5a8e:
	add r3,r0,0xc
L_8c5a92:
	add3_s r2,r2,r2
L_8c5a94:
	add r0,r0,0x1a4
L_8c5a98:
	ld_s r2,[r3,r2]
L_8c5a9a:
	add2_s r0,r0,r1
L_8c5a9c:
	st_s r2,[r0]
L_8c5a9e:
	ld_s r0,[r14,0x34]
L_8c5aa0:
	mov_s r2,0x0
L_8c5aa2:
	ldb_s r1,[r13,0x10]
L_8c5aa4:
	add r0,r0,0x184
L_8c5aa8:
	add2_s r0,r0,r1
L_8c5aaa:
	st_s r2,[r0]
	.global L_8c5aac
L_8c5aac:
	mov_s r0,0x0
L_8c5aae:
	b.d L_8c0334
L_8c5ab2:
	st_s r0,[r14,0x38]
	.global L_8c5ab4
L_8c5ab4:
	mov_s r0,blink
L_8c5ab6:
	mov_s r2,0x10113b8
L_8c5abc:
	mov_s r1,0x147a
L_8c5ac2:
	bl.d L_8c82c0
L_8c5ac6:
	mov_s r3,0xa3
L_8c5ac8:
	b_s L_8c5a88
L_8c5aca:
	nop_s
