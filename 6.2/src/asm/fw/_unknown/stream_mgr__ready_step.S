/* stream_mgr__ready_step @ 0x8e8310, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__ready_for_modify
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, mid_list__by_mid_fw, mid_list__count_active, mids__get_count, scan_resume
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__ready_step
stream_mgr__ready_step:
	.global L_8e8310
L_8e8310:
	push_s blink
L_8e8312:
	bl L_8c01e4
L_8e8316:
	bl.d L_8cc484
L_8e831a:
	sub_s sp,sp,0x4
L_8e831c:
	mov_s r1,r0
L_8e831e:
	mov_s r13,sp
L_8e8320:
	bl.d L_8e5dfc
L_8e8324:
	mov_s r0,r13
L_8e8326:
	b_s L_8e833a
	.global L_8e8328
L_8e8328:
	bl.d L_8df444
L_8e832c:
	mov_s r0,r13
L_8e832e:
	bl L_8cc3dc
L_8e8332:
	bl.d L_8cb7a0
L_8e8336:
	mov_s r14,r0
L_8e8338:
	brne_s r0,0,L_8e8348
	.global L_8e833a
L_8e833a:
	bl.d L_8cdcc4
L_8e833e:
	mov_s r0,r13
L_8e8340:
	brne_s r0,0,L_8e8328
L_8e8342:
	b.d L_8c0254
L_8e8346:
	add_s sp,sp,0x4
	.global L_8e8348
L_8e8348:
	mov_s r0,r14
L_8e834a:
	bl.d L_8f8304
L_8e834e:
	add r0,r0,0x234
L_8e8352:
	b_s L_8e833a
