/* sched__alloc_entry @ 0x8db5d8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sched__apply_entry
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sched__alloc_entry
sched__alloc_entry:
	.global L_8db5d8
L_8db5d8:
	push_s blink
L_8db5da:
	bl L_8c01e4
L_8db5de:
	mov_s r13,r0
L_8db5e0:
	bl.d L_8c3284
L_8db5e4:
	mov_s r14,r1
L_8db5e6:
	ld_s r1,[r13]
L_8db5e8:
	mov_s r2,0xc
L_8db5ea:
	stb_s r1,[r0]
L_8db5ec:
	ld_s r1,[r13,0x4]
L_8db5ee:
	stb_s r1,[r0,0x1]
L_8db5f0:
	ld_s r1,[r13,0x8]
L_8db5f2:
	stb_s r1,[r0,0x3]
L_8db5f4:
	ld_s r1,[r13,0xc]
L_8db5f6:
	stb_s r1,[r0,0x4]
L_8db5f8:
	ld_s r1,[r13,0x10]
L_8db5fa:
	st_s r14,[r0,0x8]
L_8db5fc:
	stb_s r1,[r0,0x2]
L_8db5fe:
	mov_s r1,0x42
L_8db600:
	bl.d L_8e5204
L_8db604:
	mov_s r3,0x0
L_8db606:
	b L_8c0254
L_8db60a:
	nop_s
