/* conn_mgr__find_in_ranking_list @ 0x8d725c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__add_to_rinking_list
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__has_more, iter__init, iter__next
 */
	.section .text.conn_mgr__find_in_ranking_list,"ax",@progbits
	.global conn_mgr__find_in_ranking_list
conn_mgr__find_in_ranking_list:
	.global L_8d725c
L_8d725c:
	push_s blink
L_8d725e:
	bl L_8c02c4
L_8d7262:
	sub_s sp,sp,0x4
L_8d7264:
	mov_s r14,r0
L_8d7266:
	mov_s r13,sp
L_8d7268:
	mov_s r1,0x80461c
L_8d726e:
	bl.d L_8e1138
L_8d7272:
	mov_s r0,r13
L_8d7274:
	b_s L_8d7282
	.global L_8d7276
L_8d7276:
	bl.d L_8db188
L_8d727a:
	mov_s r0,r13
L_8d727c:
	ld_s r0,[r0,0x8]
L_8d727e:
	breq r14,r0,L_8d728e
	.global L_8d7282
L_8d7282:
	bl.d L_8cb674
L_8d7286:
	mov_s r0,r13
L_8d7288:
	brne_s r0,0,L_8d7276
L_8d728a:
	mov_s r0,0x0
L_8d728c:
	b_s L_8d7290
	.global L_8d728e
L_8d728e:
	mov_s r0,0x1
	.global L_8d7290
L_8d7290:
	b.d L_8c0334
L_8d7294:
	add_s sp,sp,0x4
L_8d7296:
	nop_s
