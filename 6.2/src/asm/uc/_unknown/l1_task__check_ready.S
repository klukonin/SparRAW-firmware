/* l1_task__check_ready @ 0x928a48, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: abif__save_override_restore
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__check_ready
l1_task__check_ready:
	.global L_928a48
L_928a48:
	st.a r13,[sp,-0x10]
L_928a4c:
	st_s r15,[sp,0xc]
L_928a4e:
	mov_s r15,0x857800
L_928a54:
	ld.as r0,[r15,-0x56]
L_928a58:
	st blink,[sp, 0x4]
L_928a5c:
	brne.d r0,0x2,L_928a9c
L_928a60:
	st_s r14,[sp,0x8]
L_928a62:
	mov_s r13,0x80069c
L_928a68:
	ld r1,[r13]
L_928a6c:
	brne.d r1,0x1,L_928a98
L_928a70:
	mov_s r14,0x0
L_928a72:
	ld r4,[0x800698]
L_928a7a:
	mov_s r1,0x802408
L_928a80:
	ld r3,[0x800694]
L_928a88:
	mov r0,r14
L_928a8c:
	bl.d L_929d20
L_928a90:
	mov r2,0x7
L_928a94:
	st r14,[r13]
	.global L_928a98
L_928a98:
	st.as r14,[r15,-0x56]
	.global L_928a9c
L_928a9c:
	ld blink,[sp, 0x4]
L_928aa0:
	ld_s r14,[sp,0x8]
L_928aa2:
	ld_s r15,[sp,0xc]
L_928aa4:
	j.d [blink]
L_928aa8:
	ld.ab r13,[sp,0x10]
