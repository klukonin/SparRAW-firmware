/* list_80182c__drain_and_run @ 0x8c1a40, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.list_80182c__drain_and_run,"ax",@progbits
	.global list_80182c__drain_and_run
list_80182c__drain_and_run:
L_8c1a40:
	push_s blink
L_8c1a42:
	push_s r13
L_8c1a44:
	mov_s r1,0x80182c
L_8c1a4a:
	ld_s r13,[r1]
L_8c1a4c:
	mov_s r0,0x0
L_8c1a4e:
	st_s r0,[r1]
L_8c1a50:
	breq_s r13,0,L_8c1a5a
	.global L_8c1a52
L_8c1a52:
	ld_s r0,[r13,0x4]
L_8c1a54:
	jl_s [r0]
L_8c1a56:
	ld_s r13,[r13,0x8]
L_8c1a58:
	brne_s r13,0,L_8c1a52
	.global L_8c1a5a
L_8c1a5a:
	.byte 0xe5,0x00
