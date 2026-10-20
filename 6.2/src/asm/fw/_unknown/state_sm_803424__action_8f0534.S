/* state_sm_803424__action_8f0534 @ 0x8f0534, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   action_abort_burst() CID %d status code %d
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, state_sm_803424__action_cmp12
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_803424__action_8f0534
state_sm_803424__action_8f0534:
	.global L_8f0534
L_8f0534:
	push_s blink
L_8f0536:
	bl L_8c01e4
L_8f053a:
	mov_s r14,r2
L_8f053c:
	ld_s r2,[r0,0x10]
L_8f053e:
	mov_s r13,r0
L_8f0540:
	breq_s r2,0,L_8f0562
L_8f0542:
	ldb_s r2,[r2,0x8]
L_8f0544:
	mov_s r1,0x1019d54
L_8f054a:
	mov_s r0,0x2b
L_8f054c:
	bl.d L_8dcc80
L_8f0550:
	mov_s r3,r14
L_8f0552:
	ld_s r0,[gp,-0x74]
L_8f0554:
	ld_s r1,[r13,0x1c]
L_8f0556:
	add_s r0,r0,0x20
L_8f0558:
	bl.d L_8cb4d0
L_8f055c:
	mov_s r2,r14
L_8f055e:
	mov_s r0,0x0
L_8f0560:
	st_s r0,[r13,0x1c]
	.global L_8f0562
L_8f0562:
	b L_8c0254
L_8f0566:
	nop_s
