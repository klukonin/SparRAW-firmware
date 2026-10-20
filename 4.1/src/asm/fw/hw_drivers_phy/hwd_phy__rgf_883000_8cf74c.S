/* hwd_phy__rgf_883000_8cf74c @ 0x8cf74c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_battery_phy_step, calib_lo_leakage_step, calib_lo_power_step, calib_mngr_step_b, hwf_calib__prepare_hw, hwf_calib__setup_loopback, hwf_vga_dc__measure
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_divmod_signed, fw_sysassert_fatal
 */
	.section .text.hwd_phy__rgf_883000_8cf74c,"ax",@progbits
	.global hwd_phy__rgf_883000_8cf74c
hwd_phy__rgf_883000_8cf74c:
	.global L_8cf74c
L_8cf74c:
	push_s blink
L_8cf74e:
	bl L_8c02bc
L_8cf752:
	mov_s r16,r0
L_8cf754:
	mov_s r15,r1
L_8cf756:
	asl r0,r2,0x10
L_8cf75a:
	mov r1,0x528
L_8cf75e:
	cmp_s r2,0x0
L_8cf760:
	add.gt r0,r0,r1
L_8cf764:
	sub.le r0,r0,r1
L_8cf768:
	mov_s r1,0xa5
L_8cf76a:
	/* bl.d 0x008c03bc */
	.byte 0x56,0x0c,0x6f,0xf8
L_8cf76e:
	/* _asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8cf770:
	mov_s r14,0x883000
L_8cf776:
	st r16,[r14, 0x58]
L_8cf77a:
	bclr.f 0x0,r15,0x0
L_8cf77e:
	mov_s r13,r0
L_8cf780:
	bne_s L_8cf79e
	.global L_8cf782
L_8cf782:
	ld_s r0,[r14,0x54]
L_8cf784:
	extw_s r13,r13
L_8cf786:
	bclr_s r0,r0,0x1
L_8cf788:
	asl_s r15,r15
L_8cf78a:
	or_s r0,r0,r15
L_8cf78c:
	and r0,r0,0xfffc0003
L_8cf794:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cf796:
	or_s r13,r13,r0
L_8cf798:
	st_s r13,[r14,0x54]
L_8cf79a:
	b L_8c0324
	.global L_8cf79e
L_8cf79e:
	mov_s r0,blink
L_8cf7a0:
	mov_s r2,0x1018690
L_8cf7a6:
	mov_s r1,0xad
L_8cf7a8:
	bl.d L_8c82c0
L_8cf7ac:
	mov r3,0x2b7
L_8cf7b0:
	b_s L_8cf782
L_8cf7b2:
	nop_s
