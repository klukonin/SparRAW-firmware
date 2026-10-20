/* boot__init_once_80055c @ 0x8c1a14, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.boot__init_once_80055c,"ax",@progbits
	.global boot__init_once_80055c
boot__init_once_80055c:
L_8c1a14:
	push_s blink
L_8c1a16:
	push_s r13
L_8c1a18:
	mov_s r1,0x80055c
L_8c1a1e:
	ld_s r0,[r1]
L_8c1a20:
	brne_s r0,0,L_8c1a3c
L_8c1a22:
	mov_s r0,0x1
L_8c1a24:
	st_s r0,[r1]
L_8c1a26:
	mov_s r1,0x80182c
L_8c1a2c:
	ld_s r13,[r1,0x8]
L_8c1a2e:
	mov_s r0,0x0
L_8c1a30:
	st_s r0,[r1,0x8]
L_8c1a32:
	breq_s r13,0,L_8c1a3c
	.global L_8c1a34
L_8c1a34:
	ld_s r0,[r13,0x4]
L_8c1a36:
	jl_s [r0]
L_8c1a38:
	ld_s r13,[r13,0x8]
L_8c1a3a:
	brne_s r13,0,L_8c1a34
	.global L_8c1a3c
L_8c1a3c:
	b L_8c033c
