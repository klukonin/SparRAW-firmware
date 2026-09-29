/* obj_vt8030f4__ctor @ 0x8f532c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__init_find_sm
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__bind_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt8030f4__ctor
obj_vt8030f4__ctor:
	.global L_8f532c
L_8f532c:
	push_s blink
L_8f532e:
	bl L_8c01e4
L_8f5332:
	mov_s r14,r1
L_8f5334:
	mov_s r1,0x8030f4
L_8f533a:
	bl.d L_8d94e0
L_8f533e:
	mov_s r13,r0
L_8f5340:
	st_s r14,[r13,0x10]
L_8f5342:
	mov_s r0,0x0
L_8f5344:
	st_s r0,[r13,0x14]
L_8f5346:
	mov_s r0,0x1
L_8f5348:
	b.d L_8c0254
L_8f534c:
	stb_s r0,[r13,0x3]
L_8f534e:
	nop_s
