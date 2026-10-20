/* operational_if__mbox_init @ 0x8d6df8, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Operational MBOX init
 *   operational_if.cpp
 * Зовут его: l2mgr__init_mbox
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_sysassert_fatal, mbox__build_rings_and_pool
 */
	.section .text.operational_if__mbox_init,"ax",@progbits
	.global operational_if__mbox_init
operational_if__mbox_init:
	.global L_8d6df8
L_8d6df8:
	push_s blink
L_8d6dfa:
	bl L_8c02c4
L_8d6dfe:
	mov_s r13,r0
L_8d6e00:
	ld_s r0,[gp,-0x64]
L_8d6e02:
	sub_s sp,sp,0x10
L_8d6e04:
	brne_s r0,0,L_8d6e6a
	.global L_8d6e06
L_8d6e06:
	mov_s r2,0x1003e28
L_8d6e0c:
	mov_s r0,0x0
L_8d6e0e:
	bl.d L_8edfb0
L_8d6e12:
	mov_s r1,0x2
L_8d6e14:
	mov_s r14,0x803dbc
L_8d6e1a:
	mov_s r3,0x880318
L_8d6e20:
	mov r6,0x5
L_8d6e24:
	st r6,[sp]
L_8d6e28:
	mov_s r0,0x25
L_8d6e2a:
	st_s r0,[sp,0x4]
L_8d6e2c:
	mov r0,0x518
L_8d6e30:
	st_s r0,[sp,0x8]
L_8d6e32:
	mov r0,0x100
L_8d6e36:
	st_s r0,[sp,0xc]
L_8d6e38:
	mov_s r0,r14
L_8d6e3a:
	sub2 r1,r3,0x17
L_8d6e3e:
	sub r2,r3,0x30
L_8d6e42:
	mov r4,0x845bd4
L_8d6e4a:
	mov r5,0x850800
L_8d6e52:
	bl.d L_8f1104
L_8d6e56:
	mov r7,0x24
L_8d6e5a:
	mov_s r0,0x1
L_8d6e5c:
	st.as r0,[gp,-0x19]
L_8d6e60:
	st_s r13,[r14,0x70]
L_8d6e62:
	mov_s r0,r14
L_8d6e64:
	b.d L_8c0334
L_8d6e68:
	add_s sp,sp,0x10
	.global L_8d6e6a
L_8d6e6a:
	mov_s r0,blink
L_8d6e6c:
	mov_s r2,0x1003e14
L_8d6e72:
	mov_s r1,0x5d
L_8d6e74:
	bset_s r1,r1,0xc
L_8d6e76:
	bl.d L_8c82c0
L_8d6e7a:
	mov_s r3,0x5d
L_8d6e7c:
	b_s L_8d6e06
L_8d6e7e:
	nop_s
