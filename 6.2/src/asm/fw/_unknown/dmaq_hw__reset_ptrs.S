/* dmaq_hw__reset_ptrs @ 0x8d0d44, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dmaq_hw__reset_ptrs
dmaq_hw__reset_ptrs:
	.global L_8d0d44
L_8d0d44:
	push_s blink
L_8d0d46:
	push_s r13
L_8d0d48:
	mov_s r13,r0
L_8d0d4a:
	asl_s r0,r0,0x8
L_8d0d4c:
	add_s r0,r0,0x440c0e0
L_8d0d52:
	lsr_s r0,r0,0x3
L_8d0d54:
	st 0x80000000,[r0]
L_8d0d5c:
	sync
L_8d0d60:
	asl r0,r13,0x8
L_8d0d64:
	add_s r0,r0,0x440c140
L_8d0d6a:
	lsr_s r0,r0,0x3
L_8d0d6c:
	st 0x80000000,[r0]
L_8d0d74:
	sync
L_8d0d78:
	asl_s r13,r13,0x8
L_8d0d7a:
	add_s r13,r13,0x440c100
L_8d0d80:
	lsr_s r13,r13,0x3
L_8d0d82:
	mov_s r0,0x0
L_8d0d84:
	st_s r0,[r13]
L_8d0d86:
	sync
L_8d0d8a:
	b L_8c025c
L_8d0d8e:
	nop_s
