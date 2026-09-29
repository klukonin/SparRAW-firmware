/* fw_log__init_ring @ 0x8dcb1c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_log__init_ring
fw_log__init_ring:
	.global L_8dcb1c
L_8dcb1c:
	push_s blink
L_8dcb1e:
	bl.d L_8c01e4
L_8dcb22:
	mov_s r0,0x0
L_8dcb24:
	mov_s r13,0x843900
L_8dcb2a:
	st_s r0,[r13]
L_8dcb2c:
	mov_s r0,0x800968
L_8dcb32:
	ld_s r0,[r0]
L_8dcb34:
	add_s r14,r13,0x4
L_8dcb36:
	breq_s r0,0,L_8dcb62
	.global L_8dcb38
L_8dcb38:
	mov lp_count,0x10
L_8dcb3c:
	mov_s r1,0x0
L_8dcb3e:
	lp L_8dcb4a
L_8dcb42:
	mov_s r0,0x7
L_8dcb44:
	add_s r12,r14,r1
L_8dcb46:
	stb_s r0,[r12]
L_8dcb48:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8dcb4a
L_8dcb4a:
	add r0,r13,0x14
L_8dcb4e:
	mov_s r1,0x0
L_8dcb50:
	bl.d L_8c1cd8
L_8dcb54:
	bset_s r1,r1,0xc
L_8dcb56:
	mov_s r1,r13
L_8dcb58:
	mov_s r0,0x11
L_8dcb5a:
	asl_s r0,r0,0x13
L_8dcb5c:
	st_s r1,[r0,0x4]
L_8dcb5e:
	b L_8c0254
	.global L_8dcb62
L_8dcb62:
	mov_s r0,blink
L_8dcb64:
	bl.d L_8c9b28
L_8dcb68:
	mov_s r1,0xf8
L_8dcb6a:
	b_s L_8dcb38
