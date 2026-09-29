/* swc_psc_sm__action_start_scan @ 0x8c23ac, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   swc_psc_sm::action_start_scan - Entry
 *   swc_psc_sm::action_start_scan - Exit
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global swc_psc_sm__action_start_scan
swc_psc_sm__action_start_scan:
	.global L_8c23ac
L_8c23ac:
	push_s blink
L_8c23ae:
	bl L_8c01e4
L_8c23b2:
	mov_s r13,r0
L_8c23b4:
	mov_s r14,r1
L_8c23b6:
	mov_s r1,0x10176d4
L_8c23bc:
	bl.d L_8dcba8
L_8c23c0:
	mov_s r0,0x29
L_8c23c2:
	st_s r14,[r13,0x8]
L_8c23c4:
	mov_s r0,0x27500
L_8c23ca:
	mov_s r1,r13
L_8c23cc:
	mov_s r2,0x0
L_8c23ce:
	mov_s r3,0x1
L_8c23d0:
	mov r4,0xf4240
L_8c23d8:
	mov_s r5,r2
L_8c23da:
	bl.d L_8e0c0c
L_8c23de:
	mov_s r6,r2
L_8c23e0:
	st_s r0,[r13,0xc]
L_8c23e2:
	mov_s r1,0x10176fc
L_8c23e8:
	bl.d L_8dcba8
L_8c23ec:
	mov_s r0,0x29
L_8c23ee:
	b L_8c0254
L_8c23f2:
	nop_s
