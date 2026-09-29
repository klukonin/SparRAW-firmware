/* connection__store_ptr @ 0x8d9264, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: connection__init
 * Зовёт сам: __ld_r13_to_r13_ret, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global connection__store_ptr
connection__store_ptr:
	.global L_8d9264
L_8d9264:
	push_s blink
L_8d9266:
	push_s r13
L_8d9268:
	mov_s r13,r0
L_8d926a:
	st_s r1,[r0,0x4]
L_8d926c:
	mov_s r0,0x0
L_8d926e:
	st_s r0,[r13]
L_8d9270:
	st_s r0,[r13,0x7c]
L_8d9272:
	st_s r0,[r13,0x8]
L_8d9274:
	add r0,r13,0xc
L_8d9278:
	bl.d L_8c1cd8
L_8d927c:
	mov_s r1,0x44
L_8d927e:
	add3 r0,r13,0xa
L_8d9282:
	bl.d L_8c1cd8
L_8d9286:
	mov_s r1,0x1f
L_8d9288:
	b L_8c025c
