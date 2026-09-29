/* swc_psc_sm__action_abort_scan @ 0x8c2068, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   swc_psc_sm::action_abort_scan - Entry
 *   swc_psc_sm::action_abort_scan - Exit
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, swc_psc_sm__action_complete_scan
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global swc_psc_sm__action_abort_scan
swc_psc_sm__action_abort_scan:
	.global L_8c2068
L_8c2068:
	push_s blink
L_8c206a:
	bl L_8c01e4
L_8c206e:
	mov_s r14,r0
L_8c2070:
	mov_s r13,r1
L_8c2072:
	mov_s r1,0x1017838
L_8c2078:
	bl.d L_8dcba8
L_8c207c:
	mov_s r0,0x29
L_8c207e:
	mov_s r0,r14
L_8c2080:
	mov_s r1,r13
L_8c2082:
	mov_s r2,0x0
L_8c2084:
	bl.d L_8c2144
L_8c2088:
	mov_s r3,r2
L_8c208a:
	mov_s r1,0x1017860
L_8c2090:
	bl.d L_8dcba8
L_8c2094:
	mov_s r0,0x29
L_8c2096:
	b L_8c0254
L_8c209a:
	nop_s
