/* obj_vt80296c__ctor @ 0x8d9230, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_obj__store_desc
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__bind_descriptor, obj_vt802b50__ctor, wait_sm__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt80296c__ctor
obj_vt80296c__ctor:
	.global L_8d9230
L_8d9230:
	push_s blink
L_8d9232:
	bl L_8c01e4
L_8d9236:
	mov_s r13,r0
L_8d9238:
	mov_s r14,r1
L_8d923a:
	add_s r0,r0,0x8
L_8d923c:
	bl.d L_8f5280
L_8d9240:
	mov_s r1,r13
L_8d9242:
	add r0,r13,0x2c
L_8d9246:
	bl.d L_8d8e24
L_8d924a:
	mov_s r1,r13
L_8d924c:
	st_s r14,[r13,0x40]
L_8d924e:
	mov_s r1,0x80296c
L_8d9254:
	bl.d L_8d94e0
L_8d9258:
	mov_s r0,r13
L_8d925a:
	mov_s r0,0x1
L_8d925c:
	b.d L_8c0254
L_8d9260:
	stb_s r0,[r13,0x3]
L_8d9262:
	nop_s
