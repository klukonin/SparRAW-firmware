/* frag_8ca038 @ 0x8ca038, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_add_key__pick_mid
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__has_more, iter__init, iter__next
 */
	.section .text.frag_8ca038,"ax",@progbits
	.global frag_8ca038
frag_8ca038:
	.global L_8ca038
L_8ca038:
	push_s blink
L_8ca03a:
	bl.d L_8c02c4
L_8ca03e:
	add r1,r0,0x18
L_8ca042:
	sub_s sp,sp,0x4
L_8ca044:
	mov_s r13,sp
L_8ca046:
	bl.d L_8e1138
L_8ca04a:
	mov_s r0,r13
L_8ca04c:
	mov_s r14,0x0
L_8ca04e:
	b_s L_8ca05e
	.global L_8ca050
L_8ca050:
	bl.d L_8db188
L_8ca054:
	mov_s r0,r13
L_8ca056:
	mov_s r14,r0
L_8ca058:
	ldb r0,[r0, 0xb0]
L_8ca05c:
	brne_s r0,0,L_8ca066
	.global L_8ca05e
L_8ca05e:
	bl.d L_8cb674
L_8ca062:
	mov_s r0,r13
L_8ca064:
	brne_s r0,0,L_8ca050
	.global L_8ca066
L_8ca066:
	mov_s r0,r14
L_8ca068:
	b.d L_8c0334
L_8ca06c:
	add_s sp,sp,0x4
L_8ca06e:
	nop_s
