/* vring_schd__vring_task @ 0x8e3aa0, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_dma__get_881c80, llist__remove, vring_list__find, vring_schd__move_to_ready
 */
	.section .text.vring_schd__vring_task,"ax",@progbits
	.global vring_schd__vring_task
vring_schd__vring_task:
L_8e3aa0:
	push_s blink
L_8e3aa2:
	bl L_8c02c4
L_8e3aa6:
	mov_s r14,r0
L_8e3aa8:
	mov_s r0,0x0
L_8e3aaa:
	push_s r0
L_8e3aac:
	mov_s r13,0x804580
L_8e3ab2:
	mov_s r3,sp
L_8e3ab4:
	mov_s r0,r13
L_8e3ab6:
	mov_s r1,r13
L_8e3ab8:
	bl.d L_8e727c
L_8e3abc:
	mov_s r2,r14
L_8e3abe:
	brne r0,0x1,L_8e3aea
L_8e3ac2:
	ld_s r0,[sp,0x0]
L_8e3ac4:
	ld_s r0,[r0,0x20]
L_8e3ac6:
	cmp_s r0,0x1
L_8e3ac8:
	mov_s r0,0x1
L_8e3aca:
	sub_s.ne r0,r0,r0
L_8e3acc:
	extb.f 0x0,r0
L_8e3ad0:
	beq_s L_8e3aea
L_8e3ad2:
	bl.d L_8cdae8
L_8e3ad6:
	mov_s r0,r14
L_8e3ad8:
	breq_s r0,0,L_8e3aea
L_8e3ada:
	mov_s r0,r13
L_8e3adc:
	bl.d L_8de4ec
L_8e3ae0:
	ld_s r1,[sp,0x0]
L_8e3ae2:
	mov_s r0,r13
L_8e3ae4:
	bl.d L_8c1e44
L_8e3ae8:
	ld_s r1,[sp,0x0]
	.global L_8e3aea
L_8e3aea:
	b.d L_8c0334
L_8e3aee:
	add_s sp,sp,0x4
