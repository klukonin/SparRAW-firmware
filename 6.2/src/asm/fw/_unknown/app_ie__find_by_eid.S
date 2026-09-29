/* app_ie__find_by_eid @ 0x8cc2b8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__apply_app_ies, mid__lookup_at_48
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, app_ie__walk_list, ie_iter__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global app_ie__find_by_eid
app_ie__find_by_eid:
	.global L_8cc2b8
L_8cc2b8:
	push_s blink
L_8cc2ba:
	bl.d L_8c01e4
L_8cc2be:
	mov_s r2,r0
L_8cc2c0:
	sub_s sp,sp,0xc
L_8cc2c2:
	mov_s r13,r1
L_8cc2c4:
	mov_s r14,sp
L_8cc2c6:
	mov_s r0,r14
L_8cc2c8:
	bl.d L_8e5de8
L_8cc2cc:
	mov_s r1,r2
L_8cc2ce:
	b_s L_8cc2d6
	.global L_8cc2d0
L_8cc2d0:
	ldb_s r1,[r0]
L_8cc2d2:
	breq r13,r1,L_8cc2e0
	.global L_8cc2d6
L_8cc2d6:
	bl.d L_8df404
L_8cc2da:
	mov_s r0,r14
L_8cc2dc:
	brne_s r0,0,L_8cc2d0
L_8cc2de:
	mov_s r0,0x0
	.global L_8cc2e0
L_8cc2e0:
	b.d L_8c0254
L_8cc2e4:
	add_s sp,sp,0xc
L_8cc2e6:
	nop_s
