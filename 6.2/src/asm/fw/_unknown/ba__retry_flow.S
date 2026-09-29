/* ba__retry_flow @ 0x8f1a48, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BA retry flow (# %d)
 *   BA max retry flow (# %d) fail handle
 * Зовут его: ba_setup_sm__action_8f99e4
 * Зовёт сам: __ld_r13_to_r13_ret, ba_setup_sm__close_ba_setup_global_timeout, basic_sm__handle_event, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba__retry_flow
ba__retry_flow:
	.global L_8f1a48
L_8f1a48:
	push_s blink
L_8f1a4a:
	push_s r13
L_8f1a4c:
	ldb_s r2,[r0,0x8]
L_8f1a4e:
	brge.d r2,0x1e,L_8f1a6c
L_8f1a52:
	mov_s r13,r0
L_8f1a54:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8f1a56:
	extb_s r2,r2
L_8f1a58:
	stb_s r2,[r13,0x8]
L_8f1a5a:
	mov_s r1,0x10136b4
L_8f1a60:
	bl.d L_8dcc10
L_8f1a64:
	mov_s r0,0x25
L_8f1a66:
	mov_s r0,r13
L_8f1a68:
	mov_s r1,0x3
L_8f1a6a:
	b_s L_8f1a90
	.global L_8f1a6c
L_8f1a6c:
	mov_s r1,0x10136cc
L_8f1a72:
	bl.d L_8dcc10
L_8f1a76:
	mov_s r0,0x25
L_8f1a78:
	bl.d L_8f1bfc
L_8f1a7c:
	mov_s r0,r13
L_8f1a7e:
	ld_s r0,[r13,0x20]
L_8f1a80:
	mov_s r1,0x8
L_8f1a82:
	mov_s r2,0x1
L_8f1a84:
	mov_s r3,0x0
L_8f1a86:
	bl.d L_8d9b6c
L_8f1a8a:
	mov_s r4,r3
L_8f1a8c:
	mov_s r0,r13
L_8f1a8e:
	mov_s r1,0xa
	.global L_8f1a90
L_8f1a90:
	mov_s r2,0x0
L_8f1a92:
	mov_s r3,r2
L_8f1a94:
	bl.d L_8d9b6c
L_8f1a98:
	mov_s r4,r2
L_8f1a9a:
	b L_8c025c
L_8f1a9e:
	nop_s
