/* list_80182c__insert_sorted @ 0x8dd000, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: list_80182c__insert_obj
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.list_80182c__insert_sorted,"ax",@progbits
	.global list_80182c__insert_sorted
list_80182c__insert_sorted:
	.global L_8dd000
L_8dd000:
	push_s blink
L_8dd002:
	bl.d L_8c02c0
L_8dd006:
	mov_s r3,0x0
L_8dd008:
	mov_s r14,0x80182c
L_8dd00e:
	add2_s r14,r14,r1
L_8dd010:
	ld_s r1,[r14]
L_8dd012:
	ld_s r13,[r0]
L_8dd014:
	breq_s r1,0,L_8dd02e
	.global L_8dd016
L_8dd016:
	ld_s r15,[r1]
L_8dd018:
	breq_s r2,0,L_8dd020
L_8dd01a:
	brlo r15,r13,L_8dd024
L_8dd01e:
	b_s L_8dd02e
	.global L_8dd020
L_8dd020:
	brhs r13,r15,L_8dd02e
	.global L_8dd024
L_8dd024:
	ld_s r15,[r1,0x8]
L_8dd026:
	breq_s r15,0,L_8dd032
L_8dd028:
	mov_s r3,r1
L_8dd02a:
	mov_s r1,r15
L_8dd02c:
	b_s L_8dd016
	.global L_8dd02e
L_8dd02e:
	mov_s r15,r1
L_8dd030:
	mov_s r1,r3
	.global L_8dd032
L_8dd032:
	st_s r15,[r0,0x8]
L_8dd034:
	brne_s r1,0,L_8dd03a
L_8dd036:
	st_s r0,[r14]
L_8dd038:
	b_s L_8dd03c
	.global L_8dd03a
L_8dd03a:
	st_s r0,[r1,0x8]
	.global L_8dd03c
L_8dd03c:
	b L_8c032c
