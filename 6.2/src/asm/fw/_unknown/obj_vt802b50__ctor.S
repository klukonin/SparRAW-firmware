/* obj_vt802b50__ctor @ 0x8f5280, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: obj_vt80296c__ctor
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__bind_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt802b50__ctor
obj_vt802b50__ctor:
	.global L_8f5280
L_8f5280:
	push_s blink
L_8f5282:
	push_s r13
L_8f5284:
	mov_s r13,r0
L_8f5286:
	mov_s r0,0x0
L_8f5288:
	st_s r0,[r13,0xc]
L_8f528a:
	st_s r0,[r13,0x14]
L_8f528c:
	stb_s r0,[r13,0x9]
L_8f528e:
	st_s r1,[r13,0x20]
L_8f5290:
	mov_s r1,0x802b50
L_8f5296:
	bl.d L_8d94e0
L_8f529a:
	mov_s r0,r13
L_8f529c:
	mov_s r0,0x1
L_8f529e:
	b.d L_8c025c
L_8f52a2:
	stb_s r0,[r13,0x3]
