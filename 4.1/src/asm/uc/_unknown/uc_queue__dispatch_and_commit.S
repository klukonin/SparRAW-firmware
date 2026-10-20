/* uc_queue__dispatch_and_commit @ 0x92bd40, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__kick_and_dispatch
 * Зовёт сам: uc_deref_field4_926394
 */
	.section .text.uc_queue__dispatch_and_commit,"ax",@progbits
	.global uc_queue__dispatch_and_commit
uc_queue__dispatch_and_commit:
	.global L_92bd40
L_92bd40:
	st.a r13,[sp,-0xc]
L_92bd44:
	st blink,[sp, 0x4]
L_92bd48:
	st_s r14,[sp,0x8]
L_92bd4a:
	mov_s r13,r0
L_92bd4c:
	add r14,r0,0x24
L_92bd50:
	bl.d L_926394
L_92bd54:
	mov r0,r14
L_92bd58:
	ld_s r2,[r13,0x44]
L_92bd5a:
	mov_s r1,r0
L_92bd5c:
	ld r5,[r2, 0x4]
L_92bd60:
	jl.d [r5]
L_92bd64:
	mov r0,r13
L_92bd68:
	ld_s r3,[r13,0x24]
L_92bd6a:
	ld r4,[r14, 0xc]
L_92bd6e:
	ld blink,[sp, 0x4]
L_92bd72:
	st r3,[r4, 0x8]
L_92bd76:
	ld_s r14,[sp,0x8]
L_92bd78:
	j.d [blink]
L_92bd7c:
	ld.ab r13,[sp,0xc]
