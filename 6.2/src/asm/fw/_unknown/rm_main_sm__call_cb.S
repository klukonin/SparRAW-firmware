/* rm_main_sm__call_cb @ 0x8c59c4, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::call_cb.[Handle:0x%x][CB:0x%x][Context:0x%x]
 *   rm_main_sm::call_cb.[Handle:0x%x] CB 0x%x NOT called, state is %d
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__call_cb
rm_main_sm__call_cb:
	.global L_8c59c4
L_8c59c4:
	push_s blink
L_8c59c6:
	bl L_8c01e4
L_8c59ca:
	ld r4,[r1, 0x8]
L_8c59ce:
	mov_s r14,r0
L_8c59d0:
	mov_s r13,r1
L_8c59d2:
	brne r4,0x3,L_8c5a1c
L_8c59d6:
	ld_s r0,[r13,0x4]
L_8c59d8:
	add2 r1,r14,0x1f
L_8c59dc:
	cmp_s r1,r0
L_8c59de:
	mov_s r0,0x1
L_8c59e0:
	sub_s.ne r0,r0,r0
L_8c59e2:
	extb.f 0x0,r0
L_8c59e6:
	beq_s L_8c5a0e
	.global L_8c59e8
L_8c59e8:
	ldb_s r0,[r14,0x3]
L_8c59ea:
	ld_s r3,[r13,0xc]
L_8c59ec:
	ld r4,[r13, 0x10]
L_8c59f0:
	breq_s r0,0,L_8c5a00
L_8c59f2:
	mov_s r1,0x10193a4
L_8c59f8:
	mov_s r0,0x28
L_8c59fa:
	bl.d L_8dcd00
L_8c59fe:
	mov_s r2,r13
	.global L_8c5a00
L_8c5a00:
	mov_s r0,0x2
L_8c5a02:
	st_s r0,[r13,0x8]
L_8c5a04:
	ld_s r2,[r13,0xc]
L_8c5a06:
	mov_s r0,r13
L_8c5a08:
	jl_s.d [r2]
L_8c5a0a:
	ld_s r1,[r13,0x10]
L_8c5a0c:
	b_s L_8c5a30
	.global L_8c5a0e
L_8c5a0e:
	mov_s r0,blink
L_8c5a10:
	mov_s r1,0x1178
L_8c5a16:
	bl L_8c9b28
L_8c5a1a:
	b_s L_8c59e8
	.global L_8c5a1c
L_8c5a1c:
	ldb_s r0,[r14,0x3]
L_8c5a1e:
	breq_s r0,0,L_8c5a30
L_8c5a20:
	mov_s r1,0x10193e0
L_8c5a26:
	mov_s r0,0x28
L_8c5a28:
	mov_s r2,r13
L_8c5a2a:
	bl.d L_8dcd00
L_8c5a2e:
	ld_s r3,[r13,0xc]
	.global L_8c5a30
L_8c5a30:
	b L_8c0254
