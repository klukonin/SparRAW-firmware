/* operational_if__mbox_init @ 0x8d9f00, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Operational MBOX init
 * Зовут его: sched__step_8d9f00
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_sysassert_fatal, mbox__init_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global operational_if__mbox_init
operational_if__mbox_init:
	.global L_8d9f00
L_8d9f00:
	push_s blink
L_8d9f02:
	bl L_8c01e4
L_8d9f06:
	mov_s r14,r0
L_8d9f08:
	ld_s r0,[gp,-0x78]
L_8d9f0a:
	sub_s sp,sp,0x10
L_8d9f0c:
	brne_s r0,0,L_8d9f70
	.global L_8d9f0e
L_8d9f0e:
	mov_s r1,0x1003a50
L_8d9f14:
	bl.d L_8dcba8
L_8d9f18:
	mov_s r0,0x20
L_8d9f1a:
	mov_s r13,0x8041f0
L_8d9f20:
	mov_s r3,0x880318
L_8d9f26:
	mov r6,0x5
L_8d9f2a:
	st r6,[sp]
L_8d9f2e:
	mov_s r0,0x1b
L_8d9f30:
	st_s r0,[sp,0x4]
L_8d9f32:
	mov r0,0x518
L_8d9f36:
	st_s r0,[sp,0x8]
L_8d9f38:
	mov r0,0x100
L_8d9f3c:
	st_s r0,[sp,0xc]
L_8d9f3e:
	mov_s r0,r13
L_8d9f40:
	sub2 r1,r3,0x17
L_8d9f44:
	sub r2,r3,0x30
L_8d9f48:
	mov r4,0x845634
L_8d9f50:
	mov r5,0x851c00
L_8d9f58:
	bl.d L_8f942c
L_8d9f5c:
	mov r7,0x1a
L_8d9f60:
	mov_s r0,0x1
L_8d9f62:
	st.as r0,[gp,-0x1e]
L_8d9f66:
	st_s r14,[r13,0x78]
L_8d9f68:
	mov_s r0,r13
L_8d9f6a:
	b.d L_8c0254
L_8d9f6e:
	add_s sp,sp,0x10
	.global L_8d9f70
L_8d9f70:
	mov_s r0,blink
L_8d9f72:
	mov_s r1,0x5d
L_8d9f74:
	bl.d L_8c9b28
L_8d9f78:
	bset_s r1,r1,0xc
L_8d9f7a:
	b_s L_8d9f0e
