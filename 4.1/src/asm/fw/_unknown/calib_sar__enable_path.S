/* calib_sar__enable_path @ 0x8d36b4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_sar__vt20, hwf_calib_all
 * Зовёт сам: __ld_r13_ret, hwd_phy__rgf_885000_8cfb94, hwf_calib__release_hw
 */
	.section .text.calib_sar__enable_path,"ax",@progbits
	.global calib_sar__enable_path
calib_sar__enable_path:
	.global L_8d36b4
L_8d36b4:
	push_s blink
L_8d36b6:
	push_s r13
L_8d36b8:
	mov_s r13,r1
L_8d36ba:
	cmp_s r0,0x0
L_8d36bc:
	sub_s.ne r0,r0,r0
L_8d36be:
	mov.ne r1,r0
L_8d36c2:
	mov.ne r2,0x1
L_8d36c6:
	mov.ne r3,r0
L_8d36ca:
	mov.ne r4,0x2000
L_8d36d2:
	bl.ne.d L_8cfb94
L_8d36d6:
	mov.ne r5,r0
L_8d36da:
	cmp_s r13,0x0
L_8d36dc:
	bl.ne L_8d3738
L_8d36e0:
	b L_8c033c
