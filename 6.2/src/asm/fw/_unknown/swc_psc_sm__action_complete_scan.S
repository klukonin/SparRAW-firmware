/* swc_psc_sm__action_complete_scan @ 0x8c2144, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   swc_psc_sm::action_complete_scan - Entry
 *   swc_psc_sm::action_complete_scan - Exit
 * Зовут его: swc_psc_sm__action_abort_scan
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, scan_mngr__scan_done
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global swc_psc_sm__action_complete_scan
swc_psc_sm__action_complete_scan:
	.global L_8c2144
L_8c2144:
	push_s blink
L_8c2146:
	bl L_8c01e4
L_8c214a:
	mov_s r13,r0
L_8c214c:
	mov_s r14,r1
L_8c214e:
	mov_s r1,0x10177e4
L_8c2154:
	bl.d L_8dcba8
L_8c2158:
	mov_s r0,0x29
L_8c215a:
	ld_s r0,[r13,0x8]
L_8c215c:
	bl.d L_8f8220
L_8c2160:
	mov_s r1,r14
L_8c2162:
	mov_s r1,0x1017810
L_8c2168:
	bl.d L_8dcba8
L_8c216c:
	mov_s r0,0x29
L_8c216e:
	b L_8c0254
L_8c2172:
	nop_s
