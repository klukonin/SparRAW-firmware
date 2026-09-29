/* state_sm_803424__action_8f0500 @ 0x8f0500, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   action_abort() CID %d status code %d
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, state_sm_803424__action_cmp12
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_803424__action_8f0500
state_sm_803424__action_8f0500:
	.global L_8f0500
L_8f0500:
	push_s blink
L_8f0502:
	bl L_8c01e4
L_8f0506:
	mov_s r14,r2
L_8f0508:
	ld_s r2,[r0,0x10]
L_8f050a:
	mov_s r13,r0
L_8f050c:
	breq_s r2,0,L_8f052e
L_8f050e:
	ldb_s r2,[r2,0x8]
L_8f0510:
	mov_s r1,0x1019d2c
L_8f0516:
	mov_s r0,0x2b
L_8f0518:
	bl.d L_8dcc80
L_8f051c:
	mov_s r3,r14
L_8f051e:
	ld_s r0,[gp,-0x74]
L_8f0520:
	ld_s r1,[r13,0x1c]
L_8f0522:
	add_s r0,r0,0x20
L_8f0524:
	bl.d L_8cb4d0
L_8f0528:
	mov_s r2,r14
L_8f052a:
	mov_s r0,0x0
L_8f052c:
	st_s r0,[r13,0x1c]
	.global L_8f052e
L_8f052e:
	b L_8c0254
L_8f0532:
	nop_s
