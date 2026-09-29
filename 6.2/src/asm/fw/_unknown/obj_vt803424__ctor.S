/* obj_vt803424__ctor @ 0x8f53b8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: connection__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__bind_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt803424__ctor
obj_vt803424__ctor:
	.global L_8f53b8
L_8f53b8:
	push_s blink
L_8f53ba:
	bl L_8c01e4
L_8f53be:
	mov_s r14,r1
L_8f53c0:
	mov_s r1,0x803424
L_8f53c6:
	bl.d L_8d94e0
L_8f53ca:
	mov_s r13,r0
L_8f53cc:
	mov_s r0,0x0
L_8f53ce:
	st_s r0,[r13,0x1c]
L_8f53d0:
	mov_s r0,0x2
L_8f53d2:
	stb_s r0,[r13,0x18]
L_8f53d4:
	b.d L_8c0254
L_8f53d8:
	st_s r14,[r13,0x10]
L_8f53da:
	nop_s
