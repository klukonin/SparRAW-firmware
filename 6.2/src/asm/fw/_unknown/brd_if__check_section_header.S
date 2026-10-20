/* brd_if__check_section_header @ 0x8ebdc4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array
 * Зовёт сам: __ld_r13_to_r13_ret, brd_if_multi_array__physical_section_header_u
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if__check_section_header
brd_if__check_section_header:
	.global L_8ebdc4
L_8ebdc4:
	push_s blink
L_8ebdc6:
	push_s r13
L_8ebdc8:
	ld_s r2,[r1]
L_8ebdca:
	mov_s r0,r1
L_8ebdcc:
	lsr r1,r2,0x14
L_8ebdd0:
	bmsk_s r1,r1,0x3
L_8ebdd2:
	cmp_s r1,0x4
L_8ebdd4:
	rlc r13,0x0
L_8ebdd8:
	lsr r1,r2,0x18
L_8ebddc:
	bmsk_s r1,r1,0x1
L_8ebdde:
	cmp_s r1,0x2
L_8ebde0:
	and r2,r2,0xfc000000
L_8ebde8:
	rlc r3,0x0
L_8ebdec:
	sub.f r2,r2,0x0
L_8ebdf0:
	mov.ne r2,0x1
L_8ebdf4:
	mov_s r1,0x0
L_8ebdf6:
	cmp_s r13,0x0
L_8ebdf8:
	cmp.ne r3,0x0
L_8ebdfc:
	cmp.ne r2,0x0
L_8ebe00:
	mov.ne r1,0x1
L_8ebe04:
	extb.f r13,r1
L_8ebe08:
	bl.eq.d L_8e0f4c
L_8ebe0c:
	mov.eq r1,0x0
L_8ebe10:
	b.d L_8c025c
L_8ebe14:
	mov_s r0,r13
L_8ebe16:
	nop_s
