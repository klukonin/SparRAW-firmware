/* hwd_abif__rgf_88ae00 @ 0x8cb9a8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, power_deep_sleep_exit_step, rgf_reg_88a200
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_88ae00,"ax",@progbits
	.global hwd_abif__rgf_88ae00
hwd_abif__rgf_88ae00:
	.global L_8cb9a8
L_8cb9a8:
	push_s blink
L_8cb9aa:
	push_s r13
L_8cb9ac:
	mov_s r13,r0
L_8cb9ae:
	bclr.f r0,r0,0x0
L_8cb9b2:
	bne_s L_8cb9c6
	.global L_8cb9b4
L_8cb9b4:
	mov_s r1,0x88ae00
L_8cb9ba:
	ld_s r0,[r1,0x8]
L_8cb9bc:
	bclr_s r0,r0,0x0
L_8cb9be:
	or_s r13,r13,r0
L_8cb9c0:
	st_s r13,[r1,0x8]
L_8cb9c2:
	b L_8c033c
	.global L_8cb9c6
L_8cb9c6:
	mov_s r0,blink
L_8cb9c8:
	mov_s r2,0x1019954
L_8cb9ce:
	mov_s r1,0xac
L_8cb9d0:
	bl.d L_8c82c0
L_8cb9d4:
	mov r3,0x1c4
L_8cb9d8:
	b_s L_8cb9b4
L_8cb9da:
	nop_s
