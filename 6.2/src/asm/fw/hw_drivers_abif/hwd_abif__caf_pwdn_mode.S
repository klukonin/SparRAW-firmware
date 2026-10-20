/* hwd_abif__caf_pwdn_mode @ 0x8ce690, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, abif__mode_switch, deep_sleep_exit, rf__restore_if_needed
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__caf_pwdn_mode
hwd_abif__caf_pwdn_mode:
	.global L_8ce690
L_8ce690:
	push_s blink
L_8ce692:
	push_s r13
L_8ce694:
	mov_s r13,r0
L_8ce696:
	bclr.f r0,r0,0x0
L_8ce69a:
	bne_s L_8ce6ae
	.global L_8ce69c
L_8ce69c:
	mov_s r1,0x88ae00
L_8ce6a2:
	ld_s r0,[r1,0x8]
L_8ce6a4:
	bclr_s r0,r0,0x0
L_8ce6a6:
	or_s r13,r13,r0
L_8ce6a8:
	st_s r13,[r1,0x8]
L_8ce6aa:
	b L_8c025c
	.global L_8ce6ae
L_8ce6ae:
	mov_s r0,blink
L_8ce6b0:
	bl.d L_8c9b28
L_8ce6b4:
	mov_s r1,0xac
L_8ce6b6:
	b_s L_8ce69c
