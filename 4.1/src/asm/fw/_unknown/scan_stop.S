/* scan_stop @ 0x8f0164, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_stop()
 * Зовут его: scan_abort
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, scan_mngr__abort_scan
 */
	.section .text.scan_stop,"ax",@progbits
	.global scan_stop
scan_stop:
	.global L_8f0164
L_8f0164:
	push_s blink
L_8f0166:
	push_s r13
L_8f0168:
	mov_s r13,r0
L_8f016a:
	mov_s r2,0x1012610
L_8f0170:
	mov_s r0,0xc
L_8f0172:
	bl.d L_8edfb0
L_8f0176:
	mov_s r1,0x2
L_8f0178:
	bl.d L_8e8e0c
L_8f017c:
	ld_s r0,[r13,0x8]
L_8f017e:
	.byte 0xc1,0x01
