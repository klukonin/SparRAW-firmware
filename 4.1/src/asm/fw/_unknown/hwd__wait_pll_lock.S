/* hwd__wait_pll_lock @ 0x8cd590, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__enable_pll, hw_modes__pll_engage
 * Зовёт сам: car__enable_pll3_and_wait, car__toggle_pll_and_wait
 */
	.section .text.hwd__wait_pll_lock,"ax",@progbits
	.global hwd__wait_pll_lock
hwd__wait_pll_lock:
	.global L_8cd590
L_8cd590:
	push_s blink
L_8cd592:
	mov_s r0,0x880c00
L_8cd598:
	ld_s r0,[r0,0x50]
L_8cd59a:
	btst_s r0,0x2
L_8cd59c:
	bl.ne.d L_8cd3e0
L_8cd5a0:
	mov.ne r0,0x1
L_8cd5a4:
	mov_s r0,0x880a80
L_8cd5aa:
	ld_s r0,[r0,0x3c]
L_8cd5ac:
	btst_s r0,0x1
L_8cd5ae:
	bl.ne.d L_8cd478
L_8cd5b2:
	sub_s.ne r0,r0,r0
L_8cd5b4:
	pop_s blink
L_8cd5b6:
	j_s [blink]
