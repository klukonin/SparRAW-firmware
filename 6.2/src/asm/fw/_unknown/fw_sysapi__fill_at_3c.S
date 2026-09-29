/* fw_sysapi__fill_at_3c @ 0x8f5368, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__fill_sysapi_3c_thunk
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysapi__zero_and_fill, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi__fill_at_3c
fw_sysapi__fill_at_3c:
	.global L_8f5368
L_8f5368:
	push_s blink
L_8f536a:
	push_s r13
L_8f536c:
	bl.d L_8f7ffc
L_8f5370:
	mov_s r13,r0
L_8f5372:
	add r0,r13,0x3c
L_8f5376:
	bl.d L_8c1cd8
L_8f537a:
	mov_s r1,0x2c
L_8f537c:
	add3 r0,r13,0xd
L_8f5380:
	bl.d L_8c1cd8
L_8f5384:
	mov_s r1,0x20
L_8f5386:
	b L_8c025c
L_8f538a:
	nop_s
