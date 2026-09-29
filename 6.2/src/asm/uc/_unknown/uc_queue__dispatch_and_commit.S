/* uc_queue__dispatch_and_commit @ 0x92fb40, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__kick_and_dispatch_uc
 * Зовёт сам: uc_queue__peek_head_word1
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_queue__dispatch_and_commit
uc_queue__dispatch_and_commit:
	.global L_92fb40
L_92fb40:
	st.a r13,[sp,-0xc]
L_92fb44:
	st blink,[sp, 0x4]
L_92fb48:
	st_s r14,[sp,0x8]
L_92fb4a:
	mov_s r13,r0
L_92fb4c:
	add r14,r0,0x24
L_92fb50:
	bl.d L_927f64
L_92fb54:
	mov r0,r14
L_92fb58:
	ld_s r2,[r13,0x44]
L_92fb5a:
	mov_s r1,r0
L_92fb5c:
	ld r5,[r2, 0x4]
L_92fb60:
	jl.d [r5]
L_92fb64:
	mov r0,r13
L_92fb68:
	ld_s r3,[r13,0x24]
L_92fb6a:
	ld r4,[r14, 0xc]
L_92fb6e:
	ld blink,[sp, 0x4]
L_92fb72:
	st r3,[r4, 0x8]
L_92fb76:
	ld_s r14,[sp,0x8]
L_92fb78:
	j.d [blink]
L_92fb7c:
	ld.ab r13,[sp,0xc]
