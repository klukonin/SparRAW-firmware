/* hwd_phy__rx_postdist_force_dc_set @ 0x8d2758, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_postdist_force_dc_set
hwd_phy__rx_postdist_force_dc_set:
	.global L_8d2758
L_8d2758:
	push_s blink
L_8d275a:
	push_s r13
L_8d275c:
	mov_s r13,r0
L_8d275e:
	bclr.f r0,r0,0x0
L_8d2762:
	bne_s L_8d2778
	.global L_8d2764
L_8d2764:
	mov_s r1,0x883580
L_8d276a:
	ld_s r0,[r1,0x4]
L_8d276c:
	asl_s r13,r13,0x8
L_8d276e:
	bclr_s r0,r0,0x8
L_8d2770:
	or_s r13,r13,r0
L_8d2772:
	st_s r13,[r1,0x4]
L_8d2774:
	b L_8c025c
	.global L_8d2778
L_8d2778:
	mov_s r0,blink
L_8d277a:
	bl.d L_8c9b28
L_8d277e:
	mov_s r1,0xac
L_8d2780:
	b_s L_8d2764
L_8d2782:
	nop_s
