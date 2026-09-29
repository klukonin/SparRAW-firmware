/* frag_8ca7ac @ 0x8ca7ac, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.frag_8ca7ac,"ax",@progbits
	.global frag_8ca7ac
frag_8ca7ac:
L_8ca7ac:
	push_s blink
L_8ca7ae:
	push_s r13
L_8ca7b0:
	ld r3,[r0, 0x8c]
L_8ca7b4:
	add r2,r0,0x34
L_8ca7b8:
	ld_s r0,[r3]
L_8ca7ba:
	ld_s r13,[r0,0xc]
L_8ca7bc:
	jl_s.d [r13]
L_8ca7be:
	mov_s r0,r3
L_8ca7c0:
	b L_8c033c
