/* hwd_phy__rgf_883000_8cf52c @ 0x8cf52c, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_lo_power_step, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__release_hw
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_phy__rgf_883000_8cf52c,"ax",@progbits
	.global hwd_phy__rgf_883000_8cf52c
hwd_phy__rgf_883000_8cf52c:
	.global L_8cf52c
L_8cf52c:
	push_s blink
L_8cf52e:
	bl L_8c02c0
L_8cf532:
	mov_s r15,r0
L_8cf534:
	bclr.f r0,r0,0x0
L_8cf538:
	mov_s r13,r1
L_8cf53a:
	bne_s L_8cf55e
	.global L_8cf53c
L_8cf53c:
	mov_s r14,0xffff8000
L_8cf542:
	tst_s r13,r14
L_8cf544:
	bne_s L_8cf572
	.global L_8cf546
L_8cf546:
	mov_s r0,0x883000
L_8cf54c:
	ld_s r1,[r0,0x48]
L_8cf54e:
	asl_s r15,r15,0xf
L_8cf550:
	bclr_s r1,r1,0xf
L_8cf552:
	or_s r15,r15,r1
L_8cf554:
	and_s r14,r14,r15
L_8cf556:
	or_s r13,r13,r14
L_8cf558:
	st_s r13,[r0,0x48]
L_8cf55a:
	b L_8c032c
	.global L_8cf55e
L_8cf55e:
	mov_s r0,blink
L_8cf560:
	mov_s r2,0x1018690
L_8cf566:
	mov_s r1,0xad
L_8cf568:
	bl.d L_8c82c0
L_8cf56c:
	mov r3,0x237
L_8cf570:
	b_s L_8cf53c
	.global L_8cf572
L_8cf572:
	mov_s r0,blink
L_8cf574:
	mov_s r2,0x1018690
L_8cf57a:
	mov_s r1,0xae
L_8cf57c:
	bl.d L_8c82c0
L_8cf580:
	mov r3,0x237
L_8cf584:
	b_s L_8cf546
L_8cf586:
	nop_s
