/* scan_stop @ 0x8f8368, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_stop()
 * Зовут его: scan_abort
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, scan_mngr__abort_scan
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_stop
scan_stop:
	.global L_8f8368
L_8f8368:
	push_s blink
L_8f836a:
	push_s r13
L_8f836c:
	mov_s r13,r0
L_8f836e:
	mov_s r1,0x1016dec
L_8f8374:
	bl.d L_8dcba8
L_8f8378:
	mov_s r0,0x2c
L_8f837a:
	bl.d L_8f04bc
L_8f837e:
	ld_s r0,[r13,0x8]
L_8f8380:
	b L_8c025c
