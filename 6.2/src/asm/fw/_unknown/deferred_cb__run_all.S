/* deferred_cb__run_all @ 0x8c1ca0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global deferred_cb__run_all
deferred_cb__run_all:
L_8c1ca0:
	push_s blink
L_8c1ca2:
	push_s r13
L_8c1ca4:
	mov_s r1,0x801b1c
L_8c1caa:
	ld_s r13,[r1]
L_8c1cac:
	mov_s r0,0x0
L_8c1cae:
	st_s r0,[r1]
L_8c1cb0:
	breq_s r13,0,L_8c1cba
	.global L_8c1cb2
L_8c1cb2:
	ld_s r0,[r13,0x4]
L_8c1cb4:
	jl_s [r0]
L_8c1cb6:
	ld_s r13,[r13,0x8]
L_8c1cb8:
	brne_s r13,0,L_8c1cb2
	.global L_8c1cba
L_8c1cba:
	b L_8c025c
L_8c1cbe:
	nop_s
