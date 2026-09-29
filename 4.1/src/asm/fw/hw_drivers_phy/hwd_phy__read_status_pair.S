/* hwd_phy__read_status_pair @ 0x8cf6f8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, ber_test__measure, calib_battery__check_limits, calib_lo_leakage_step, hwf_dc_calib_fix_dac1, hwf_vga_dc__measure
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, memset0_words
 */
	.section .text.hwd_phy__read_status_pair,"ax",@progbits
	.global hwd_phy__read_status_pair
hwd_phy__read_status_pair:
	.global L_8cf6f8
L_8cf6f8:
	push_s blink
L_8cf6fa:
	push_s r13
L_8cf6fc:
	mov.f r13,r0
L_8cf700:
	beq_s L_8cf734
	.global L_8cf702
L_8cf702:
	mov_s r0,r13
L_8cf704:
	bl.d L_8c1a78
L_8cf708:
	mov_s r1,0x8
L_8cf70a:
	mov_s r1,0x883000
L_8cf710:
	ld_s r0,[r1,0x10]
L_8cf712:
	bset_s r0,r0,0x3
L_8cf714:
	st_s r0,[r1,0x10]
	.global L_8cf716
L_8cf716:
	mov_s r2,0x883680
L_8cf71c:
	ld_s r0,[r2,0x6c]
L_8cf71e:
	bbit0 r0,0x0,L_8cf716
L_8cf722:
	ld_s r0,[r2,0x64]
L_8cf724:
	st_s r0,[r13]
L_8cf726:
	ld_s r0,[r2,0x68]
L_8cf728:
	st_s r0,[r13,0x4]
L_8cf72a:
	ld_s r0,[r1,0x10]
L_8cf72c:
	bclr_s r0,r0,0x3
L_8cf72e:
	st_s r0,[r1,0x10]
L_8cf730:
	b L_8c033c
	.global L_8cf734
L_8cf734:
	mov_s r0,blink
L_8cf736:
	mov_s r2,0x1018690
L_8cf73c:
	mov_s r1,0xe0
L_8cf73e:
	bset_s r1,r1,0xc
L_8cf740:
	bl.d L_8c82c0
L_8cf744:
	mov r3,0x2be
L_8cf748:
	b_s L_8cf702
L_8cf74a:
	nop_s
