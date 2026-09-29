/* evt_queue__take_locked @ 0x926a3c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_evt__send_29_sync
 * Зовёт сам: evt_queue__noop_lock_hook, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global evt_queue__take_locked
evt_queue__take_locked:
	.global L_926a3c
L_926a3c:
	st.a r13,[sp,-0x18]
L_926a40:
	st blink,[sp, 0x4]
L_926a44:
	st_s r14,[sp,0x8]
L_926a46:
	st_s r15,[sp,0xc]
L_926a48:
	st r16,[sp, 0x10]
L_926a4c:
	st r17,[sp, 0x14]
L_926a50:
	mov_s r17,r0
L_926a52:
	mov.f r14,r1
L_926a56:
	mov_s r16,r2
L_926a58:
	beq.d L_926aa0
L_926a5c:
	mov r15,r3
	.global L_926a60
L_926a60:
	lr r13,[0xa]
L_926a64:
	bclr r1,r13,0x1
L_926a68:
	flag r1
L_926a6c:
	add r0,r17,0x4
L_926a70:
	mov_s r1,r14
L_926a72:
	mov_s r2,r16
L_926a74:
	bl.d L_926a38
L_926a78:
	mov r3,r15
L_926a7c:
	lr r0,[0xa]
L_926a80:
	bic r13,r13,-0x3
L_926a84:
	or_s r13,r13,r0
L_926a86:
	flag r13
L_926a8a:
	ld blink,[sp, 0x4]
L_926a8e:
	ld_s r14,[sp,0x8]
L_926a90:
	ld_s r15,[sp,0xc]
L_926a92:
	ld r16,[sp, 0x10]
L_926a96:
	ld r17,[sp, 0x14]
L_926a9a:
	j_s.d [blink]
L_926a9c:
	ld.ab r13,[sp,0x18]
	.global L_926aa0
L_926aa0:
	mov r0,blink
L_926aa4:
	bl.d L_926618
L_926aa8:
	mov r1,0xc2
L_926aac:
	b_s L_926a60
L_926aae:
	nop_s
