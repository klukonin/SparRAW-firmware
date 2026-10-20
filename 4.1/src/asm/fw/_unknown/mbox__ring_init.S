/* mbox__ring_init @ 0x8decf8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_mailbox__init_rings, mbox__init_debug, mbox__init_operational
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, deref_0_4
 */
	.section .text.mbox__ring_init,"ax",@progbits
	.global mbox__ring_init
mbox__ring_init:
	.global L_8decf8
L_8decf8:
	push_s blink
L_8decfa:
	bl L_8c02c4
L_8decfe:
	mov_s r13,r0
L_8ded00:
	add r14,r0,0x24
L_8ded04:
	bl.d L_8ca7f4
L_8ded08:
	mov_s r0,r14
L_8ded0a:
	mov_s r1,r0
L_8ded0c:
	ld_s r0,[r13,0x44]
L_8ded0e:
	ld_s r2,[r0,0x4]
L_8ded10:
	jl_s.d [r2]
L_8ded12:
	mov_s r0,r13
L_8ded14:
	ld_s r1,[r14,0xc]
L_8ded16:
	ld_s r0,[r14]
L_8ded18:
	b.d L_8c0334
L_8ded1c:
	st_s r0,[r1,0x8]
L_8ded1e:
	nop_s
