/* hwd__wait_pll_lock @ 0x8d041c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__enable_pll, hw_modes__pll_engage
 * Зовёт сам: car__enable_pll3_and_wait, pcie__toggle_880c50_bit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd__wait_pll_lock
hwd__wait_pll_lock:
	.global L_8d041c
L_8d041c:
	push_s blink
L_8d041e:
	mov_s r0,0x880c00
L_8d0424:
	ld_s r0,[r0,0x50]
L_8d0426:
	btst_s r0,0x2
L_8d0428:
	bl.ne.d L_8d029c
L_8d042c:
	mov.ne r0,0x1
L_8d0430:
	mov_s r0,0x880a80
L_8d0436:
	ld_s r0,[r0,0x3c]
L_8d0438:
	btst_s r0,0x1
L_8d043a:
	bl.ne.d L_8d0320
L_8d043e:
	sub_s.ne r0,r0,r0
L_8d0440:
	pop_s blink
L_8d0442:
	j_s [blink]
