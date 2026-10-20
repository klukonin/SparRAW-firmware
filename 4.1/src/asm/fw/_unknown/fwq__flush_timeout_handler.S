/* fwq__flush_timeout_handler @ 0x8c90d8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   flush_timeout_handler for fwq 0x%X
 * Зовёт сам: __ld_r13_ret, frag_8e4734, fw_log__emit1
 */
	.section .text.fwq__flush_timeout_handler,"ax",@progbits
	.global fwq__flush_timeout_handler
fwq__flush_timeout_handler:
L_8c90d8:
	push_s blink
L_8c90da:
	push_s r13
L_8c90dc:
	mov_s r13,r0
L_8c90de:
	mov_s r2,0x10157e4
L_8c90e4:
	mov_s r0,0x7
L_8c90e6:
	mov_s r1,0x2
L_8c90e8:
	bl.d L_8edfcc
L_8c90ec:
	mov_s r3,r13
L_8c90ee:
	mov_s r0,0x0
L_8c90f0:
	st_s r0,[r13,0x10]
L_8c90f2:
	ld_s r0,[r13,0x4c]
L_8c90f4:
	ld_s r1,[r0,0xc]
L_8c90f6:
	jl_s.d [r1]
L_8c90f8:
	mov_s r0,r13
L_8c90fa:
	b L_8c033c
L_8c90fe:
	nop_s
L_8c9100:
	b L_8e4738
