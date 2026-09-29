/* vring_schd__move_ready_if_idle @ 0x8e8a70, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_dma__get_881c80, tx_list__remove, vring_list__find, vring_schd__move_to_ready
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__move_ready_if_idle
vring_schd__move_ready_if_idle:
	.global L_8e8a70
L_8e8a70:
	push_s blink
L_8e8a72:
	bl L_8c01e4
L_8e8a76:
	mov_s r14,r0
L_8e8a78:
	mov_s r0,0x0
L_8e8a7a:
	push_s r0
L_8e8a7c:
	mov_s r13,0x804dbc
L_8e8a82:
	mov_s r3,sp
L_8e8a84:
	mov_s r0,r13
L_8e8a86:
	add_s r1,r13,0x4
L_8e8a88:
	bl.d L_8ebe80
L_8e8a8c:
	mov_s r2,r14
L_8e8a8e:
	brne r0,0x1,L_8e8aba
L_8e8a92:
	ld_s r0,[sp,0x0]
L_8e8a94:
	ld_s r0,[r0,0x20]
L_8e8a96:
	cmp_s r0,0x1
L_8e8a98:
	mov_s r0,0x1
L_8e8a9a:
	sub_s.ne r0,r0,r0
L_8e8a9c:
	extb.f 0x0,r0
L_8e8aa0:
	beq_s L_8e8aba
L_8e8aa2:
	bl.d L_8d0894
L_8e8aa6:
	mov_s r0,r14
L_8e8aa8:
	breq_s r0,0,L_8e8aba
L_8e8aaa:
	add_s r0,r13,0x4
L_8e8aac:
	bl.d L_8e2884
L_8e8ab0:
	ld_s r1,[sp,0x0]
L_8e8ab2:
	mov_s r0,r13
L_8e8ab4:
	bl.d L_8c24b0
L_8e8ab8:
	ld_s r1,[sp,0x0]
	.global L_8e8aba
L_8e8aba:
	b.d L_8c0254
L_8e8abe:
	add_s sp,sp,0x4
