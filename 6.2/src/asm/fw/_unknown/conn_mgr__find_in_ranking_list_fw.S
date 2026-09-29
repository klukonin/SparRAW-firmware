/* conn_mgr__find_in_ranking_list_fw @ 0x8da308, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__add_to_rinking_list
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__find_in_ranking_list_fw
conn_mgr__find_in_ranking_list_fw:
	.global L_8da308
L_8da308:
	push_s blink
L_8da30a:
	bl L_8c01e4
L_8da30e:
	sub_s sp,sp,0x4
L_8da310:
	mov_s r14,r0
L_8da312:
	mov_s r13,sp
L_8da314:
	mov_s r1,0x854000
L_8da31a:
	bl.d L_8e5df4
L_8da31e:
	mov_s r0,r13
L_8da320:
	b_s L_8da32e
	.global L_8da322
L_8da322:
	bl.d L_8df438
L_8da326:
	mov_s r0,r13
L_8da328:
	ld_s r0,[r0,0x8]
L_8da32a:
	breq r14,r0,L_8da33a
	.global L_8da32e
L_8da32e:
	bl.d L_8cdcb8
L_8da332:
	mov_s r0,r13
L_8da334:
	brne_s r0,0,L_8da322
L_8da336:
	mov_s r0,0x0
L_8da338:
	b_s L_8da33c
	.global L_8da33a
L_8da33a:
	mov_s r0,0x1
	.global L_8da33c
L_8da33c:
	b.d L_8c0254
L_8da340:
	add_s sp,sp,0x4
L_8da342:
	nop_s
