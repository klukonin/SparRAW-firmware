/* vring_list__find @ 0x8e727c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__alloc_pring, vring_schd__resume_vring, vring_schd__stop_vring, vring_schd__unbind_vring, vring_schd__vring_task
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, iter__has_more, iter__init, iter__next
 */
	.section .text.vring_list__find,"ax",@progbits
	.global vring_list__find
vring_list__find:
	.global L_8e727c
L_8e727c:
	push_s blink
L_8e727e:
	bl.d L_8c02c0
L_8e7282:
	mov_s r0,0x0
L_8e7284:
	sub_s sp,sp,0x4
L_8e7286:
	mov_s r14,r2
L_8e7288:
	mov_s r15,r3
L_8e728a:
	st_s r0,[r3]
L_8e728c:
	mov_s r13,sp
L_8e728e:
	bl.d L_8e1138
L_8e7292:
	mov_s r0,r13
L_8e7294:
	b_s L_8e72a2
	.global L_8e7296
L_8e7296:
	bl.d L_8db188
L_8e729a:
	mov_s r0,r13
L_8e729c:
	ldb_s r1,[r0,0x9]
L_8e729e:
	breq r14,r1,L_8e72ae
	.global L_8e72a2
L_8e72a2:
	bl.d L_8cb674
L_8e72a6:
	mov_s r0,r13
L_8e72a8:
	brne_s r0,0,L_8e7296
L_8e72aa:
	mov_s r0,0x0
L_8e72ac:
	b_s L_8e72b2
	.global L_8e72ae
L_8e72ae:
	st_s r0,[r15]
L_8e72b0:
	mov_s r0,0x1
	.global L_8e72b2
L_8e72b2:
	b.d L_8c032c
L_8e72b6:
	add_s sp,sp,0x4
