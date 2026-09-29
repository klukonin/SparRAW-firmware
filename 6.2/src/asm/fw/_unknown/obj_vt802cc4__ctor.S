/* obj_vt802cc4__ctor @ 0x8f52bc, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: obj_vt802da0__ctor
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__bind_descriptor, obj_vt802cc4__noop_vmethod, obj_vt802f58__ctor
 * Глобалы (через gp): 0x80046c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt802cc4__ctor
obj_vt802cc4__ctor:
	.global L_8f52bc
L_8f52bc:
	push_s blink
L_8f52be:
	bl L_8c01e4
L_8f52c2:
	mov_s r14,r1
L_8f52c4:
	mov_s r1,0x802cc4
L_8f52ca:
	bl.d L_8d94e0
L_8f52ce:
	mov_s r13,r0
L_8f52d0:
	add r0,r13,0x2c
L_8f52d4:
	bl.d L_8d8dc0
L_8f52d8:
	mov_s r1,r13
L_8f52da:
	mov_s r0,0x2
L_8f52dc:
	mov_s r1,0x0
L_8f52de:
	st_s r0,[r13,0xc]
L_8f52e0:
	mov_s r0,0x803c00
L_8f52e6:
	st_s r1,[r13,0x1c]
L_8f52e8:
	st_s r1,[r13,0x20]
L_8f52ea:
	st_s r1,[r13,0x24]
L_8f52ec:
	st_s r1,[r13,0x28]
L_8f52ee:
	st_s r14,[r13,0x8]
L_8f52f0:
	ld_s r0,[r0,0x20]
L_8f52f2:
	bbit0 r0,0x6,L_8f5300
L_8f52f6:
	st 0x2710,[r13, 0x14]
L_8f52fe:
	b_s L_8f5304
	.global L_8f5300
L_8f5300:
	ld_s r0,[gp,0x2e8]
L_8f5302:
	st_s r0,[r13,0x14]
	.global L_8f5304
L_8f5304:
	stb_s r1,[r13,0x19]
L_8f5306:
	bl.d L_8c67b8
L_8f530a:
	mov_s r0,r13
L_8f530c:
	b L_8c0254
