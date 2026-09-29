/* ies_block__find_ie @ 0x8ca090, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_scheduled_dti__update_ie, mid__apply_app_ies
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ie_iter__init, ie_iter__next, ies__has_buffer
 */
	.section .text.ies_block__find_ie,"ax",@progbits
	.global ies_block__find_ie
ies_block__find_ie:
	.global L_8ca090
L_8ca090:
	push_s blink
L_8ca092:
	bl.d L_8c02c4
L_8ca096:
	mov_s r2,r0
L_8ca098:
	sub_s sp,sp,0xc
L_8ca09a:
	mov_s r13,r1
L_8ca09c:
	mov_s r14,sp
L_8ca09e:
	mov_s r0,r14
L_8ca0a0:
	bl.d L_8e112c
L_8ca0a4:
	mov_s r1,r2
L_8ca0a6:
	b_s L_8ca0b4
	.global L_8ca0a8
L_8ca0a8:
	bl.d L_8db160
L_8ca0ac:
	mov_s r0,r14
L_8ca0ae:
	ldb_s r1,[r0]
L_8ca0b0:
	breq r13,r1,L_8ca0be
	.global L_8ca0b4
L_8ca0b4:
	bl.d L_8cb668
L_8ca0b8:
	mov_s r0,r14
L_8ca0ba:
	brne_s r0,0,L_8ca0a8
L_8ca0bc:
	mov_s r0,0x0
	.global L_8ca0be
L_8ca0be:
	b.d L_8c0334
L_8ca0c2:
	add_s sp,sp,0xc
