/* hwd_phy__rx_postdist_dc_enable @ 0x8d26d0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_postdist_dc_enable
hwd_phy__rx_postdist_dc_enable:
	.global L_8d26d0
L_8d26d0:
	push_s blink
L_8d26d2:
	push_s r13
L_8d26d4:
	cmp_s r0,0x0
L_8d26d6:
	mov_s r13,0x1
L_8d26d8:
	sub_s.ne r13,r13,r13
L_8d26da:
	mov_s r12,r13
L_8d26dc:
	bic.f r12,r12,-0xff
L_8d26e0:
	bne_s L_8d26f6
	.global L_8d26e2
L_8d26e2:
	mov_s r1,0x883580
L_8d26e8:
	ld_s r0,[r1,0x4]
L_8d26ea:
	asl_s r13,r13,0x9
L_8d26ec:
	bclr_s r0,r0,0x9
L_8d26ee:
	or_s r13,r13,r0
L_8d26f0:
	st_s r13,[r1,0x4]
L_8d26f2:
	b L_8c025c
	.global L_8d26f6
L_8d26f6:
	mov_s r0,blink
L_8d26f8:
	bl.d L_8c9b28
L_8d26fc:
	mov_s r1,0xac
L_8d26fe:
	b_s L_8d26e2
