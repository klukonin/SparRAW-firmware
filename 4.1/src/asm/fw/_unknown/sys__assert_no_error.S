/* sys__assert_no_error @ 0x8c8208, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_spi_read, l2mgr__disconnect_done, lmac_if__lmac_ready_evt, marlon_r_if__write_verify, wbe_driver__pcie_debug_isr
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.sys__assert_no_error,"ax",@progbits
	.global sys__assert_no_error
sys__assert_no_error:
	.global L_8c8208
L_8c8208:
	push_s blink
L_8c820a:
	push_s r13
L_8c820c:
	mov_s r13,0x857000
L_8c8212:
	ld_s r13,[r13,0x1c]
L_8c8214:
	cmp_s r13,0x0
L_8c8216:
	bl.ne L_8c82c0
L_8c821a:
	b L_8c033c
L_8c821e:
	nop_s
