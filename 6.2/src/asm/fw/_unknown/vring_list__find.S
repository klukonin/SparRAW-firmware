/* vring_list__find @ 0x8ebe80, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__delete_vring, vring_schd__alloc_pring, vring_schd__move_ready_if_idle, vring_schd__resume_vring, vring_schd__stop_vring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_list__find
vring_list__find:
	.global L_8ebe80
L_8ebe80:
	push_s blink
L_8ebe82:
	bl.d L_8c01e0
L_8ebe86:
	mov_s r0,0x0
L_8ebe88:
	sub_s sp,sp,0x4
L_8ebe8a:
	mov_s r14,r2
L_8ebe8c:
	mov_s r15,r3
L_8ebe8e:
	st_s r0,[r3]
L_8ebe90:
	mov_s r13,sp
L_8ebe92:
	bl.d L_8e5df4
L_8ebe96:
	mov_s r0,r13
L_8ebe98:
	b_s L_8ebea6
	.global L_8ebe9a
L_8ebe9a:
	bl.d L_8df438
L_8ebe9e:
	mov_s r0,r13
L_8ebea0:
	ldb_s r1,[r0,0x9]
L_8ebea2:
	breq r14,r1,L_8ebeb2
	.global L_8ebea6
L_8ebea6:
	bl.d L_8cdcb8
L_8ebeaa:
	mov_s r0,r13
L_8ebeac:
	brne_s r0,0,L_8ebe9a
L_8ebeae:
	mov_s r0,0x0
L_8ebeb0:
	b_s L_8ebeb6
	.global L_8ebeb2
L_8ebeb2:
	st_s r0,[r15]
L_8ebeb4:
	mov_s r0,0x1
	.global L_8ebeb6
L_8ebeb6:
	b.d L_8c024c
L_8ebeba:
	add_s sp,sp,0x4
