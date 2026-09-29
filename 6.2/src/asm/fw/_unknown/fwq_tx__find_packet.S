/* fwq_tx__find_packet @ 0x8cc710, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__on_flush_done
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__find_packet
fwq_tx__find_packet:
	.global L_8cc710
L_8cc710:
	push_s blink
L_8cc712:
	bl L_8c01e4
L_8cc716:
	sub_s sp,sp,0x4
L_8cc718:
	mov_s r14,r2
L_8cc71a:
	mov_s r13,sp
L_8cc71c:
	bl.d L_8e5df4
L_8cc720:
	mov_s r0,r13
L_8cc722:
	b_s L_8cc730
	.global L_8cc724
L_8cc724:
	bl.d L_8df438
L_8cc728:
	mov_s r0,r13
L_8cc72a:
	ldb_s r1,[r0,0xa]
L_8cc72c:
	breq r14,r1,L_8cc73a
	.global L_8cc730
L_8cc730:
	bl.d L_8cdcb8
L_8cc734:
	mov_s r0,r13
L_8cc736:
	brne_s r0,0,L_8cc724
L_8cc738:
	mov_s r0,0x0
	.global L_8cc73a
L_8cc73a:
	b.d L_8c0254
L_8cc73e:
	add_s sp,sp,0x4
