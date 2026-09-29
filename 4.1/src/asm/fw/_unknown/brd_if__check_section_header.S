/* brd_if__check_section_header @ 0x8e7198, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__check_physical_section_validity
 * Зовёт сам: __ld_r13_ret, brd_if_multi_array__physical_section_header_u__print2log
 */
	.section .text.brd_if__check_section_header,"ax",@progbits
	.global brd_if__check_section_header
brd_if__check_section_header:
	.global L_8e7198
L_8e7198:
	push_s blink
L_8e719a:
	push_s r13
L_8e719c:
	ld_s r2,[r1]
L_8e719e:
	mov_s r0,r1
L_8e71a0:
	lsr r1,r2,0x14
L_8e71a4:
	bmsk_s r1,r1,0x3
L_8e71a6:
	cmp_s r1,0x4
L_8e71a8:
	rlc r13,0x0
L_8e71ac:
	lsr r1,r2,0x18
L_8e71b0:
	bmsk_s r1,r1,0x1
L_8e71b2:
	cmp_s r1,0x2
L_8e71b4:
	and r2,r2,0xfc000000
L_8e71bc:
	rlc r3,0x0
L_8e71c0:
	sub.f r2,r2,0x0
L_8e71c4:
	mov.ne r2,0x1
L_8e71c8:
	mov_s r1,0x0
L_8e71ca:
	cmp_s r13,0x0
L_8e71cc:
	cmp.ne r3,0x0
L_8e71d0:
	cmp.ne r2,0x0
L_8e71d4:
	mov.ne r1,0x1
L_8e71d8:
	extb.f r13,r1
L_8e71dc:
	bl.eq.d L_8dcc98
L_8e71e0:
	mov.eq r1,0x0
L_8e71e4:
	b.d L_8c033c
L_8e71e8:
	mov_s r0,r13
L_8e71ea:
	nop_s
