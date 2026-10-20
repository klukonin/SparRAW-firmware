/* scan_abort @ 0x8f81fc, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_abort()
 * Зовут его: l2_mgr__aborting_scan, l2_mgr__scan_abort
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, scan_stop
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_abort
scan_abort:
	.global L_8f81fc
L_8f81fc:
	push_s blink
L_8f81fe:
	push_s r13
L_8f8200:
	mov_s r13,r0
L_8f8202:
	mov_s r1,0x1016df8
L_8f8208:
	bl.d L_8dcba8
L_8f820c:
	mov_s r0,0x2c
L_8f820e:
	ld_s r1,[r13,0x8]
L_8f8210:
	mov_s r0,0x1
L_8f8212:
	st.as r0,[r1,0x72]
L_8f8216:
	bl.d L_8f8368
L_8f821a:
	mov_s r0,r13
L_8f821c:
	b L_8c025c
