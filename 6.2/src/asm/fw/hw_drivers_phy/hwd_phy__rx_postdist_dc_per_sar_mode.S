/* hwd_phy__rx_postdist_dc_per_sar_mode @ 0x8d2700, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_postdist_dc_per_sar_mode
hwd_phy__rx_postdist_dc_per_sar_mode:
	.global L_8d2700
L_8d2700:
	push_s blink
L_8d2702:
	push_s r13
L_8d2704:
	mov_s r13,r0
L_8d2706:
	bclr.f r0,r0,0x0
L_8d270a:
	bne_s L_8d271e
	.global L_8d270c
L_8d270c:
	mov_s r1,0x885180
L_8d2712:
	ld_s r0,[r1,0x20]
L_8d2714:
	bclr_s r0,r0,0x0
L_8d2716:
	or_s r13,r13,r0
L_8d2718:
	st_s r13,[r1,0x20]
L_8d271a:
	b L_8c025c
	.global L_8d271e
L_8d271e:
	mov_s r0,blink
L_8d2720:
	bl.d L_8c9b28
L_8d2724:
	mov_s r1,0xac
L_8d2726:
	b_s L_8d270c
