/* basic_sm__error_handler @ 0x8c9a54, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_sm::error_handler event: %s  SM: %s  STATE: %s
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, fwq_tx__long_retry_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global basic_sm__error_handler
basic_sm__error_handler:
	.global L_8c9a54
L_8c9a54:
	push_s blink
L_8c9a56:
	push_s r13
L_8c9a58:
	ld_s r3,[r0,0x4]
L_8c9a5a:
	ldb_s r13,[r0,0x1]
L_8c9a5c:
	ld_s r2,[r3,0xc]
L_8c9a5e:
	mov_s r1,0x1001a3c
L_8c9a64:
	ld.as r2,[r2,r13]
L_8c9a68:
	ldb_s r13,[r0]
L_8c9a6a:
	ld_s r0,[r3,0x8]
L_8c9a6c:
	ld.as r4,[r0,r13]
L_8c9a70:
	mov_s r0,0x5
L_8c9a72:
	bl.d L_8dce84
L_8c9a76:
	ld_s r3,[r3,0x10]
L_8c9a78:
	mov_s r0,blink
L_8c9a7a:
	mov_s r1,0x33
L_8c9a7c:
	bl.d L_8c9b28
L_8c9a80:
	bset_s r1,r1,0xc
L_8c9a82:
	b L_8c025c
L_8c9a86:
	nop_s
