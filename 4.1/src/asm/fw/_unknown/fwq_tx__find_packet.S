/* fwq_tx__find_packet @ 0x8ca508, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__on_flush_done
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__has_more, iter__init, iter__next
 */
	.section .text.fwq_tx__find_packet,"ax",@progbits
	.global fwq_tx__find_packet
fwq_tx__find_packet:
	.global L_8ca508
L_8ca508:
	push_s blink
L_8ca50a:
	bl L_8c02c4
L_8ca50e:
	sub_s sp,sp,0x4
L_8ca510:
	mov_s r14,r2
L_8ca512:
	mov_s r13,sp
L_8ca514:
	bl.d L_8e1138
L_8ca518:
	mov_s r0,r13
L_8ca51a:
	b_s L_8ca528
	.global L_8ca51c
L_8ca51c:
	bl.d L_8db188
L_8ca520:
	mov_s r0,r13
L_8ca522:
	ldb_s r1,[r0,0xa]
L_8ca524:
	breq r14,r1,L_8ca532
	.global L_8ca528
L_8ca528:
	bl.d L_8cb674
L_8ca52c:
	mov_s r0,r13
L_8ca52e:
	brne_s r0,0,L_8ca51c
L_8ca530:
	mov_s r0,0x0
	.global L_8ca532
L_8ca532:
	b.d L_8c0334
L_8ca536:
	add_s sp,sp,0x4
