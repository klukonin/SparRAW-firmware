/* link_stats__calc_goodput @ 0x8c48ec, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_div_unsigned, get_p8003b4_48, get_p8003b4_50
 */
	.section .text.link_stats__calc_goodput,"ax",@progbits
	.global link_stats__calc_goodput
link_stats__calc_goodput:
	.global L_8c48ec
L_8c48ec:
	push_s blink
L_8c48ee:
	bl L_8c02b8
L_8c48f2:
	mov_s r13,r0
L_8c48f4:
	mov_s r14,r1
L_8c48f6:
	mov_s r16,r2
L_8c48f8:
	ld_s r15,[r0,0x50]
L_8c48fa:
	bl.d L_8d9ac8
L_8c48fe:
	ld r17,[r0, 0x54]
L_8c4902:
	bl.d L_8d9ad0
L_8c4906:
	st_s r0,[r13,0x50]
L_8c4908:
	st_s r0,[r13,0x54]
L_8c490a:
	ld_s r13,[r13,0x50]
L_8c490c:
	sub r0,r0,r17
L_8c4910:
	sub_s r13,r13,r15
L_8c4912:
	add.f r13,r13,r0
L_8c4916:
	mov.eq r0,0xffffffff
L_8c491e:
	beq_s L_8c492c
L_8c4920:
	mulu64 r0,0x64
L_8c4924:
	mov_s r0,mlo
L_8c4926:
	bl.d L_8c03b4
L_8c492a:
	mov_s r1,r13
	.global L_8c492c
L_8c492c:
	st_s r0,[r14]
L_8c492e:
	b.d L_8c031c
L_8c4932:
	st r13,[r16]
L_8c4936:
	nop_s
