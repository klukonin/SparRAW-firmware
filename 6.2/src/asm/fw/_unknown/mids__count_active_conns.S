/* mids__count_active_conns @ 0x8cb8b0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_assoc_mgr__shallow_sleep_enter
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, mid__count_active_conns, mid_list__by_mid_fw, mids__get_count
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mids__count_active_conns
mids__count_active_conns:
	.global L_8cb8b0
L_8cb8b0:
	push_s blink
L_8cb8b2:
	bl L_8c01e4
L_8cb8b6:
	sub_s sp,sp,0x4
L_8cb8b8:
	bl.d L_8cc484
L_8cb8bc:
	mov_s r13,0x0
L_8cb8be:
	mov_s r1,r0
L_8cb8c0:
	mov_s r14,sp
L_8cb8c2:
	bl.d L_8e5dfc
L_8cb8c6:
	mov_s r0,r14
L_8cb8c8:
	b_s L_8cb8da
	.global L_8cb8ca
L_8cb8ca:
	bl.d L_8df444
L_8cb8ce:
	mov_s r0,r14
L_8cb8d0:
	bl L_8cc3dc
L_8cb8d4:
	bl L_8cc66c
L_8cb8d8:
	add_s r13,r13,r0
	.global L_8cb8da
L_8cb8da:
	bl.d L_8cdcc4
L_8cb8de:
	mov_s r0,r14
L_8cb8e0:
	brne_s r0,0,L_8cb8ca
L_8cb8e2:
	extb_s r0,r13
L_8cb8e4:
	b.d L_8c0254
L_8cb8e8:
	add_s sp,sp,0x4
L_8cb8ea:
	nop_s
