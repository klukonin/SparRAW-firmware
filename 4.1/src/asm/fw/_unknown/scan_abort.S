/* scan_abort @ 0x8eff54, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_abort()
 * Зовут его: l2_mgr__aborting_scan, l2_mgr__scan_abort
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, scan_stop
 */
	.section .text.scan_abort,"ax",@progbits
	.global scan_abort
scan_abort:
	.global L_8eff54
L_8eff54:
	push_s blink
L_8eff56:
	push_s r13
L_8eff58:
	mov_s r13,r0
L_8eff5a:
	mov_s r2,0x101261c
L_8eff60:
	mov_s r0,0xc
L_8eff62:
	bl.d L_8edfb0
L_8eff66:
	mov_s r1,0x2
L_8eff68:
	ld_s r1,[r13,0x8]
L_8eff6a:
	mov_s r0,0x1
L_8eff6c:
	st r0,[r1, 0x80]
L_8eff70:
	bl.d L_8f0164
L_8eff74:
	mov_s r0,r13
L_8eff76:
	b L_8c033c
L_8eff7a:
	nop_s
