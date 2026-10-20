/* uc_mailbox__next_slot @ 0x927e6c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_mailbox.cpp
 * Зовут его: uc_mailbox__dispatch_one
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_mailbox__next_slot,"ax",@progbits
	.global uc_mailbox__next_slot
uc_mailbox__next_slot:
	.global L_927e6c
L_927e6c:
	st.a r13,[sp,-0xc]
L_927e70:
	ld_s r13,[r0]
L_927e72:
	st_s r14,[sp,0x8]
L_927e74:
	ld_s r2,[r0,0x8]
L_927e76:
	add_s r13,r13,0x8
L_927e78:
	st blink,[sp, 0x4]
L_927e7c:
	brlo.d r2,r13,L_927e94
L_927e80:
	mov r14,r0
	.global L_927e84
L_927e84:
	brne r13,r2,L_927eb0
L_927e88:
	ld r1,[r14, 0x4]
L_927e8c:
	b.d L_927eb4
L_927e90:
	st r1,[r14]
	.global L_927e94
L_927e94:
	mov_s r0,blink
L_927e96:
	mov_s r2,0x1001174
L_927e9c:
	mov r1,0xcc
L_927ea0:
	bl.d L_925548
L_927ea4:
	mov r3,0xb2
L_927ea8:
	b.d L_927e84
L_927eac:
	ld r2,[r14, 0x8]
	.global L_927eb0
L_927eb0:
	st r13,[r14]
	.global L_927eb4
L_927eb4:
	ld blink,[sp, 0x4]
L_927eb8:
	ld_s r14,[sp,0x8]
L_927eba:
	j_s.d [blink]
L_927ebc:
	ld.ab r13,[sp,0xc]
